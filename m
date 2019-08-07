Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203DE846C7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfHGIHP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 04:07:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57842 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbfHGIHP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 04:07:15 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190807080712epoutp0286832f5bfcba6010fd68d09233c3e383~4lXxuqcnI2148421484epoutp02M
        for <linux-pm@vger.kernel.org>; Wed,  7 Aug 2019 08:07:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190807080712epoutp0286832f5bfcba6010fd68d09233c3e383~4lXxuqcnI2148421484epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565165232;
        bh=PeE7VB47v5DstVn25w1iQxP2DLTkXCMIZuhpW8+XalI=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=VKH3JmPBwW5M7LTHAoBk/dhX5eBO8J73KPSYgDvvN45DpekfJEM6d0v15P3hKK7JO
         7CThildIfiLCUpxHsdDj37D7za+mXGKr223SzZfDFvlmpSXf2V+GsNjFTIb8NFfBKR
         NsJgp6k099BVsoAgR7TouhtkSuofX3siMz5HrnGs=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190807080711epcas1p1c7ce15a52d252d787dd88d59fc2eb148~4lXxG-Gmb2167521675epcas1p1E;
        Wed,  7 Aug 2019 08:07:11 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 463PHK2HzJzMqYkj; Wed,  7 Aug
        2019 08:07:09 +0000 (GMT)
X-AuditID: b6c32a38-b33ff70000001040-67-5d4a86ad5062
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.17.04160.DA68A4D5; Wed,  7 Aug 2019 17:07:09 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH] PM / devfreq: Add dev_pm_qos support
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Artur Swigon <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190807080709epcms1p666f0a1ba637e020b484e62129a0345c9@epcms1p6>
Date:   Wed, 07 Aug 2019 17:07:09 +0900
X-CMS-MailID: 20190807080709epcms1p666f0a1ba637e020b484e62129a0345c9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmvu7aNq9YgxltQhaHjm1lt/h6+hSj
        xctDmhbXvzxntZi+dxObxfnzG9gtzja9YbdYcfcjq0XXr5XMFp97jzBanDl9Ccg99JfNYuNX
        Dwdej/c3Wtk9Fmwq9di0qpPN4861PWweG9/tYPI4+G4Pk8eWq+0sHn1bVjF6fN4kF8AZlW2T
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3S1kkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3uDQvXS85P9fK0MDAyBSoMCE7Y9KN
        woIegYq21V8YGxjX8HYxcnJICJhILJjQxNTFyMUhJLCDUeLfm9VADgcHr4CgxN8dwiA1wgKW
        Emd3rmcEsYUElCQabu5jhojrS3Q82AYWZxPQldi64S4LyBwRgVVAc7a/BRvKLPCISeLc9OVM
        ENt4JWa0P2WBsKUlti/fCtbNKRAnsff3EzaIuKjEzdVv2WHs98fmM0LYIhKt984yQ9iCEg9+
        7maEmTNjyn+omdUS16YvZgdZLCHQwijRu3oKVJG+xJm5J8EW8Ar4Stw9sA6sgUVAVeLFy99Q
        x7lIPHjaDraAWUBeYvvbOcygkGAW0JRYv0sfokRRYufvuYwwvzRs/M2OzmYW4JN497WHFSa+
        Y94TqPFqEod2L4Gql5E4PX0h8wRGpVmIsJ6FZPEshMULGJlXMYqlFhTnpqcWGxaYIMfuJkZw
        Ctay2MG455zPIUYBDkYlHl6LLs9YIdbEsuLK3EOMEhzMSiK898qAQrwpiZVVqUX58UWlOanF
        hxhNgf6fyCwlmpwPzA95JfGGpkbGxsYWJoZmpoaGSuK8C39YxAoJpCeWpGanphakFsH0MXFw
        SjUw5lfe5toh8nOC4RIjnoXcshOT/xil3X2/LrUpkD1Z/OL7H2rMFpeuzJf7U8T9Jot5Wd6+
        52e3f1y2KfdNhPx0NnGFk41ab1ITb+x7d22F4Zf1EXP2S6s5KeUknXGUWjQxK4hLVz0qukxC
        wF4r9qix2qytjvE38kzOsb2+KXTgT1Cf/u471+LTlViKMxINtZiLihMBDkh0F9cDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190806090343epcas1p366bca79527337fcc169ff5c4451f2129
References: <bcbab490489ef5143361048db93752741b38e379.1565081126.git.leonard.crestez@nxp.com>
        <CGME20190806090343epcas1p366bca79527337fcc169ff5c4451f2129@epcms1p6>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>Add dev_pm_qos notifies to devfreq core in order to support frequency
>limits via dev_pm_qos_add_request and related APIs
>
>Unlike the rest of devfreq the dev_pm_qos frequency is measured kHz:
>this is consistent with current dev_pm_qos usage for cpufreq and allows
>frequencies above 2Ghz.
>
>Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
[]
>diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>index 784c08e4f931..de9e825ae1f4 100644
>--- a/drivers/devfreq/devfreq.c
>+++ b/drivers/devfreq/devfreq.c
[]
>+	/*
>+	 * notifier from pm_qos
>+	 *
>+	 * initialized outside of devfreq->lock to avoid circular warning
>+	 * between devfreq->lock and dev_pm_qos_mtx
>+	 */
>+	devfreq->nb_min.notifier_call = devfreq_qos_min_notifier_call;
>+	devfreq->nb_max.notifier_call = devfreq_qos_max_notifier_call;
>+
>+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_min,
>+				      DEV_PM_QOS_MIN_FREQUENCY);
>+	if (err) {
>+		dev_err(dev, "Failed to register MIN QoS notifier: %d\n", err);
>+		panic("fail\n");
>+		goto err_dev;
>+	}
>+
>+	err = dev_pm_qos_add_notifier(devfreq->dev.parent, &devfreq->nb_max,
>+				      DEV_PM_QOS_MAX_FREQUENCY);
>+	if (err) {
>+		dev_err(dev, "Failed to register MAX QoS notifier: %d\n", err);
>+		panic("fail\n");
>+		goto err_dev;
>+	}

Do you really need to have two notifier blocks?
Wouldn't it be sufficient to register the same notifier block for both types?

[]
>diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>index 2bae9ed3c783..939cb025d2aa 100644
>--- a/include/linux/devfreq.h
>+++ b/include/linux/devfreq.h
>@@ -176,10 +176,13 @@ struct devfreq {
> 	unsigned int *trans_table;
> 	unsigned long *time_in_state;
> 	unsigned long last_stat_updated;
> 
> 	struct srcu_notifier_head transition_notifier_list;
>+
>+	struct notifier_block nb_min;
>+	struct notifier_block nb_max;

Need Doxygen entries.

> };
> 
> struct devfreq_freqs {
> 	unsigned long old;
> 	unsigned long new;


Cheers,
MyungJoo
