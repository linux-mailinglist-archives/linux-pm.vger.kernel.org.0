Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7A1E36DD
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 06:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgE0EGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 00:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgE0EGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 00:06:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCD4C03E97D
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 21:06:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so11183177pgn.5
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 21:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c7mmaWIhliSekrXxz20ZW1Ppbz2gcfDYDdhA8q0rEGw=;
        b=WdYG8D0JMfocNaSyB3kzR5gMVArCgT76OxP6MQ+pOzljOaoPmsxhznQi5FqWaStJFl
         lmTeWzYx5wPIgZAgg5ZFh1BQ4Yr9gqWGLEB7F4urpZ1Jnzq7IObLbhJNfUvMvWly+R+k
         uIzi49ZKS2aYnGejb8FjLfdye2J/j+BkLJZxdG64a0ETBYOjwhc09VIKUQESULFfdTCK
         G9S93Jd404+Mqzi2cpaNktkrpkuj2pKavzR+KPzN5uwVxxzBN/r8yWL1muX8SJ/54zJo
         H+yIYntYyYAwe+XkogvmXQcO5urNUSM7I1UFZ2l/b9ZS8OSJNlY6yxsp8jByejOISnvi
         ofqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c7mmaWIhliSekrXxz20ZW1Ppbz2gcfDYDdhA8q0rEGw=;
        b=dik97ssTpdqeAgA/YX7Vr5t0u2g3iNXEU8SfliRa8cnlfIJOAAjgXvKBkX9b0rD6Xf
         P/d+aib8laM15xCbKCQm/sim27zAlUFWfiWa4w4K517XYQmSlwbhs35x8n/mUqV4h8Er
         nW31Wx6QL4raqN8zkTAc/rOYozlBGLNA562OKYTIecc6uQAENSDi3yKMBvIVocDQ4eel
         bIO7NgQWFUrSRl3F3gl71plQS0/51+1bLtxEK7tYTu4nVDAlo/g/sRAlp+7qrX8RpKew
         YUUF4T+Kabd3EVP+nusZgEZZL+MKCdu+poXCygJHHjbfJ8YL3dgaH7ni40hv5EdAm1Rw
         9zCw==
X-Gm-Message-State: AOAM532/Nb8EpxUXCCiETU3hTeUeD4fjAjyrSJ5gQnGsGHuC2dBFSWVX
        hlaK56o9jBAyBABs1nDXW+SqVg==
X-Google-Smtp-Source: ABdhPJzopaTwRs6857IVLls5+Ux3GcVORnkKoE0IaW4/vMYy76PnhRsBBvhJDfafZnmxdp601/HxaA==
X-Received: by 2002:a63:8f46:: with SMTP id r6mr2123412pgn.257.1590552363359;
        Tue, 26 May 2020 21:06:03 -0700 (PDT)
Received: from localhost ([122.172.60.59])
        by smtp.gmail.com with ESMTPSA id m2sm798738pfe.141.2020.05.26.21.06.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 21:06:01 -0700 (PDT)
Date:   Wed, 27 May 2020 09:35:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org,
        bjorn.andersson@linaro.org, saravanak@google.com, mka@chromium.org,
        nm@ti.com, agross@kernel.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, vincent.guittot@linaro.org,
        amit.kucheria@linaro.org, ulf.hansson@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com
Subject: Re: [PATCH v4 06/12] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200527040559.5dryuxbf5ejzvpst@vireshk-i7>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-7-sibis@codeaurora.org>
 <20200505045012.zfx2e6chqo5f3e4n@vireshk-i7>
 <8fc5b72c9af6fd6a707a280cfc678677@codeaurora.org>
 <b7e184b2da5b780a4e7e6ee47963f9b4@codeaurora.org>
 <20200527035349.mrvvxeg3lqv53jm2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527035349.mrvvxeg3lqv53jm2@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-05-20, 09:23, Viresh Kumar wrote:
> On 26-05-20, 23:18, Sibi Sankar wrote:
> > https://patchwork.kernel.org/cover/11548479/
> > GPU driver uses Georgi's series
> > for scaling and will need a way to
> > remove the icc votes in the suspend
> > path, (this looks like a pattern
> > that might be used by other clients
> > as well) I could probably update
> > opp_set_bw to support removing bw
> > when NULL opp is specified. Similarly
> > opp_set_rate will need to support
> > set bw to 0 when set_rate is passed
> > 0 as target freq for the same use case.
> 
> Sure, please send a patch for that.

On a second thought, here is the patch. Please test it.

-------------------------8<-------------------------

Subject: [PATCH] opp: Remove bandwidth votes when target_freq is zero

We already drop several votes when target_freq is set to zero, drop
bandwidth votes as well.

Reported-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 47 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 56d3022c1ca2..0c259d5ed232 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -725,6 +725,34 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
 	return ret;
 }
 
+static int _set_opp_bw(const struct opp_table *opp_table,
+		       struct dev_pm_opp *opp, bool remove)
+{
+	u32 avg, peak;
+	int i, ret;
+
+	if (!opp_table->paths)
+		return 0;
+
+	for (i = 0; i < opp_table->path_count; i++) {
+		if (remove) {
+			avg = 0;
+			peak = 0;
+		} else {
+			avg = opp->bandwidth[i].avg;
+			peak = opp->bandwidth[i].peak;
+		}
+		ret = icc_set_bw(opp_table->paths[i], avg, peak);
+		if (ret) {
+			dev_err(dev, "Failed to %s bandwidth[%d]: %d\n",
+				remove ? "remove" : "set", i, ret);
+			retrun ret;
+		}
+	}
+
+	return 0;
+}
+
 static int _set_opp_custom(const struct opp_table *opp_table,
 			   struct device *dev, unsigned long old_freq,
 			   unsigned long freq,
@@ -837,12 +865,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		if (!_get_opp_count(opp_table))
 			return 0;
 
-		if (!opp_table->required_opp_tables && !opp_table->regulators) {
+		if (!opp_table->required_opp_tables && !opp_table->regulators &&
+		    !opp_table->paths) {
 			dev_err(dev, "target frequency can't be 0\n");
 			ret = -EINVAL;
 			goto put_opp_table;
 		}
 
+		ret = _set_opp_bw(opp_table, opp, true);
+		if (ret)
+			return ret;
+
 		if (opp_table->regulator_enabled) {
 			regulator_disable(opp_table->regulators[0]);
 			opp_table->regulator_enabled = false;
@@ -932,16 +965,8 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
 
-	if (!ret && opp_table->paths) {
-		for (i = 0; i < opp_table->path_count; i++) {
-			ret = icc_set_bw(opp_table->paths[i],
-					 opp->bandwidth[i].avg,
-					 opp->bandwidth[i].peak);
-			if (ret)
-				dev_err(dev, "Failed to set bandwidth[%d]: %d\n",
-					i, ret);
-		}
-	}
+	if (!ret)
+		ret = _set_opp_bw(opp_table, opp, false);
 
 put_opp:
 	dev_pm_opp_put(opp);
