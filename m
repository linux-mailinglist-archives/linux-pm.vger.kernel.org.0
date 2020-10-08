Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690CF286FB2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgJHHkz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 03:40:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:29362 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgJHHkx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 03:40:53 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201008074048epoutp03edfc86a14f86fb029cd8b6129b3b4d56~79G6j7bZu2827028270epoutp03Q
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 07:40:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201008074048epoutp03edfc86a14f86fb029cd8b6129b3b4d56~79G6j7bZu2827028270epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602142848;
        bh=39e6ExivY2mFstp/IgohV18Cb7Qm5EgUQCntjmAe8+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsj9ZzPReUZTKw9CBh2ooxPwvclVYxAtOapJxp3WJUVwjGvTMI6ZYlAiE+fQ0G4IA
         1M+ECzB9m36XcIZyfhqPAChjdU633ENvdcEovLyi6u1QfqPTsOXyv7B/f78Vu0Bdtp
         DdFxj5L/OgB/uKglzEyz7vbdnRoevqbwwPg0nsKQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20201008074048epcas1p403bfb934b10db239fad69ab0663949ee~79G6If4vk2325723257epcas1p4W;
        Thu,  8 Oct 2020 07:40:48 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.155]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4C6NRK3MfKzMqYkf; Thu,  8 Oct
        2020 07:40:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.7B.10463.972CE7F5; Thu,  8 Oct 2020 16:40:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201008074041epcas1p33c3d6c73cf926f6d38d498e7dc15ea04~79G0BeMWJ0764107641epcas1p3N;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201008074041epsmtrp17f3a00e7fc78162887e0edb72401fd73~79G0AdJZW2784427844epsmtrp14;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-53-5f7ec279e97f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.AB.08604.972CE7F5; Thu,  8 Oct 2020 16:40:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008074041epsmtip153f27c707580b9be0b1492f3efe09928~79GzyNcCQ3068830688epsmtip1R;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 2/3] PM / devfreq: Unify frequency change to
 devfreq_update_target func
Date:   Thu,  8 Oct 2020 16:54:02 +0900
Message-Id: <20201008075403.26181-3-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008075403.26181-1-cw00.choi@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmrm7lobp4g0X/bCwm3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8WlAwuYLD5veMxocbtxBZvFvo4HTA6cHrMbLrJ4tOy7xe6xaVUn
        m8f7fVfZPPq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BZYFecWJu
        cWleul5yfq6VoYGBkSlQYUJ2xpPnC1gLtqpVXNi6j7GB8bN8FyMnh4SAicS199eZuxi5OIQE
        djBK7LvUyAjhfGKUmH53CTuE841RorXvFRtMy7x5W1hBbCGBvYwSF/YGQRR9YZR4dH8nO0iC
        TUBLYv+LG2ANIgJWEqf/d4DtYBaYzyjx9+5PRpCEsECkxI2LS1lAbBYBVYkDG7cxgdi8QA19
        q1qZILbJS6zecIAZxOYUsJb4fvoH2CAJgUfsElt/72OHKHKRmHvyEtR5whKvjm+BiktJvOxv
        g7KrJVaePMIG0dzBKLFl/wVWiISxxP6lk4G2cQCdpymxfpc+RFhRYufvuWCHMgvwSbz72sMK
        UiIhwCvR0SYEUaIscfnBXag7JSUWt3dCneAhcXbLMmg49jFKzLzQxTSBUW4WwoYFjIyrGMVS
        C4pz01OLDQtMkONsEyM43WlZ7GCc+/aD3iFGJg7GQ4wSHMxKIrzp3jXxQrwpiZVVqUX58UWl
        OanFhxhNgaE3kVlKNDkfmHDzSuINTY2MjY0tTAzNTA0NlcR5H95SiBcSSE8sSc1OTS1ILYLp
        Y+LglGpg6rQ+su7zD5Hw48qPVCwfFh4I/PwsIs6w8UnC19rL0lo9ombRgb8UQkP9M4Wicqvu
        SYit2M148pHvwyWMx26W1x1dze1c9O/6/qenFOcHny2q7uL5EyOtrXd4xZ7Q0nMPLqSvWOUg
        Hyc0WbdXuq8syHC39AehqQ78BdxK17p04naUVkzlUgtLM2N+eth+61S9N0elPrm+jUn4/pHr
        74nYu9s0b7wX5u9+8n7b5r0LD+g89MtYeTT40Y30fNVLz4/NXOrWKlEwZdGN44/P8QevazX9
        tKuBnaXD1Mers8rwyv2lvHpPeiuTps98fGVyzEG9oppJq27dcXVq5Og4GdP/+lnokz2Pf7dt
        ObEkMPHOdCWW4oxEQy3mouJEAJudD68ABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnG7lobp4g1VbRC0m3rjCYnH9y3NW
        i7NNb9gtLu+aw2bxufcIo8WlAwuYLD5veMxocbtxBZvFvo4HTA6cHrMbLrJ4tOy7xe6xaVUn
        m8f7fVfZPPq2rGL0+LxJLoAtissmJTUnsyy1SN8ugSvjyfMFrAVb1SoubN3H2MD4Wb6LkZND
        QsBEYt68LaxdjFwcQgK7GSWa23ayQiQkJaZdPMrcxcgBZAtLHD5cDFHziVHi6fkGJpAaNgEt
        if0vbrCB2CICNhJ3F19jAbGZBZYzSsxtFQSxhQXCJd7P7mUGsVkEVCUObNwG1ssrYCXRt6qV
        CWKXvMTqDQfAajgFrCW+n/4BZgsB1azc94RpAiPfAkaGVYySqQXFuem5xYYFhnmp5XrFibnF
        pXnpesn5uZsYwSGppbmDcfuqD3qHGJk4GA8xSnAwK4nwpnvXxAvxpiRWVqUW5ccXleakFh9i
        lOZgURLnvVG4ME5IID2xJDU7NbUgtQgmy8TBKdXANFmjq2du8M9NH7f1BDgKCTA8m/qTqbvq
        9jb191OU72pXG/hWirqsWStxdXbVth9P99+zXMGctXDCnynadSJ/UwtO3BDe1NB402mnk6OA
        adkMaZGLl45e6nbf52d/hiH/NHuu3ed9rGZ/j1w8vviVRMzRe9snTM1xLuZw9ZZNtv8neuuq
        uNvKZxbeGi18HL8fr57tuuSMl97Sf1PNGxsXTt7E9pbD5PmTJW7ba+zOh79daqO0ojT64tFX
        X9IML3/3adjhe1jw2ZXS44rpi62YZ8VP0e56toZ3Tkv46gMMKxXsLp0XEb6WnRdjKmfylicy
        +/oze3tl5VrLqyL/fzxdZNmoO+3Er/RfOzJuFf99c0WJpTgj0VCLuag4EQD8SDKOuAIAAA==
X-CMS-MailID: 20201008074041epcas1p33c3d6c73cf926f6d38d498e7dc15ea04
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201008074041epcas1p33c3d6c73cf926f6d38d498e7dc15ea04
References: <20201008075403.26181-1-cw00.choi@samsung.com>
        <CGME20201008074041epcas1p33c3d6c73cf926f6d38d498e7dc15ea04@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The update_devfreq() and update_passive_devfreq() have the duplicate
code when changing the target frequency on final stage. So, unify
frequency change code to devfreq_update_target() to remove the
duplicate code and to centralize the frequency change code.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c          | 29 ++++++++++++++++-----
 drivers/devfreq/governor.h         |  1 +
 drivers/devfreq/governor_passive.c | 42 +++++++-----------------------
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 379aaaabf25d..5b069a8a1026 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -384,18 +384,19 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	return err;
 }
 
-/* Load monitoring helper functions for governors use */
-
 /**
- * update_devfreq() - Reevaluate the device and configure frequency.
+ * devfreq_update_target() - Reevaluate the device and configure frequency
+ *			   on the final stage.
  * @devfreq:	the devfreq instance.
+ * @freq:	the new frequency of parent device. This argument
+ *		is only used for devfreq device using passive governor.
  *
- * Note: Lock devfreq->lock before calling update_devfreq
- *	 This function is exported for governors.
+ * Note: Lock devfreq->lock before calling devfreq_update_target. This function
+ *	 should be only used by both update_devfreq() and devfreq governors.
  */
-int update_devfreq(struct devfreq *devfreq)
+int devfreq_update_target(struct devfreq *devfreq, unsigned long freq)
 {
-	unsigned long freq, min_freq, max_freq;
+	unsigned long min_freq, max_freq;
 	int err = 0;
 	u32 flags = 0;
 
@@ -420,7 +421,21 @@ int update_devfreq(struct devfreq *devfreq)
 	}
 
 	return devfreq_set_target(devfreq, freq, flags);
+}
+EXPORT_SYMBOL(devfreq_update_target);
+
+/* Load monitoring helper functions for governors use */
 
+/**
+ * update_devfreq() - Reevaluate the device and configure frequency.
+ * @devfreq:	the devfreq instance.
+ *
+ * Note: Lock devfreq->lock before calling update_devfreq
+ *	 This function is exported for governors.
+ */
+int update_devfreq(struct devfreq *devfreq)
+{
+	return devfreq_update_target(devfreq, 0L);
 }
 EXPORT_SYMBOL(update_devfreq);
 
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index eb6392d397b3..871150be4391 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -85,6 +85,7 @@ int devfreq_add_governor(struct devfreq_governor *governor);
 int devfreq_remove_governor(struct devfreq_governor *governor);
 
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
+int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
 
 static inline int devfreq_update_stats(struct devfreq *df)
 {
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index 432a4cc683f7..8deb071d5d26 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -92,36 +92,6 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
 	return ret;
 }
 
-static int update_devfreq_passive(struct devfreq *devfreq, unsigned long freq)
-{
-	int ret;
-
-	if (!devfreq->governor)
-		return -EINVAL;
-
-	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
-
-	ret = devfreq->governor->get_target_freq(devfreq, &freq);
-	if (ret < 0)
-		goto out;
-
-	ret = devfreq->profile->target(devfreq->dev.parent, &freq, 0);
-	if (ret < 0)
-		goto out;
-
-	if (devfreq->profile->freq_table
-		&& (devfreq_update_status(devfreq, freq)))
-		dev_err(&devfreq->dev,
-			"Couldn't update frequency transition information.\n");
-
-	devfreq->previous_freq = freq;
-
-out:
-	mutex_unlock(&devfreq->lock);
-
-	return 0;
-}
-
 static int devfreq_passive_notifier_call(struct notifier_block *nb,
 				unsigned long event, void *ptr)
 {
@@ -131,17 +101,25 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
 	struct devfreq *parent = (struct devfreq *)data->parent;
 	struct devfreq_freqs *freqs = (struct devfreq_freqs *)ptr;
 	unsigned long freq = freqs->new;
+	int ret = 0;
 
+	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
 	switch (event) {
 	case DEVFREQ_PRECHANGE:
 		if (parent->previous_freq > freq)
-			update_devfreq_passive(devfreq, freq);
+			ret = devfreq_update_target(devfreq, freq);
+
 		break;
 	case DEVFREQ_POSTCHANGE:
 		if (parent->previous_freq < freq)
-			update_devfreq_passive(devfreq, freq);
+			ret = devfreq_update_target(devfreq, freq);
 		break;
 	}
+	mutex_unlock(&devfreq->lock);
+
+	if (ret < 0)
+		dev_warn(&devfreq->dev,
+			"failed to update devfreq using passive governor\n");
 
 	return NOTIFY_DONE;
 }
-- 
2.17.1

