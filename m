Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E563A3E502D
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 01:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhHIX5Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 19:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHIX5Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 19:57:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED3C0613D3;
        Mon,  9 Aug 2021 16:56:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n17so12318304lft.13;
        Mon, 09 Aug 2021 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wP2bayLmU+3K18X+SE8nuL9RPrBb9v8I/h7ZwghcHyc=;
        b=jtBA8OX0piq6L6d+cUYv0qXKlJ00wiGPTtae34YO3dHTzchRsCEFwOseq8Y1d7IdEu
         ivWSUigsp+2RNnEuh9vO1dYGKD28mbADWlLE5HkfznL/9mgglj7MkgwGer/rA6uNBJtG
         oJ/p2NO+NwWWTgiFcSVE0J2wA0eoCTDbgyraSFkuEI4+KpKl4USYxPsiGvvijQDC9vTv
         sFp/Z1eTvS0UW5GsCd8hflafQq91rUce8FJeGbnADp2yQT3qRwy+0QtZFdoVsPjhLb/2
         roXSLb7yqKAEkb8UIx44+8iMsOtbB07YWAt/UpplU4J0x0eY/ejvXo4ras9YCKzvGxWD
         QXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wP2bayLmU+3K18X+SE8nuL9RPrBb9v8I/h7ZwghcHyc=;
        b=nqomB4jprrczmnE1wIPV9WEYSCUz29O4FBSsWsjk/RC2x1jLPEp8dkd0IA/8DZW1Gp
         T/blx2tczY93Q4jaFZDSGMxcegdFYBtlVT4LIxZ14uc39Bo8Ex4qHDCCK48tKsEBh7nY
         zHAwkrMPlMD0/ptvRRzvBXUQzHUPZm7msblkr1A/HmCBT6LLHf5sIYon82xoa4oC/VP7
         04aCk2t/D/3Fr+lWYD5DH2tu+5Z4XaIRua3jQPd/tT6VaBIQuKfr97SCQxZqVDR1TQzl
         FB7Uxbuv4GlgLHYL7SKK8pP9ywQhs5CHygF2Q2Ms1dEI6V41g5UmvSeL0tp7C49YNHMp
         gV6A==
X-Gm-Message-State: AOAM533lWDSD7lahH+faH7phO/aIDUzwneGiF93jBHH3bzs/s8zBlqUa
        DUvUj5vB8TcJHqVsssuN93OMrA5fDR0=
X-Google-Smtp-Source: ABdhPJxbznr9B+GvA4Ip6tbIHh9Mks/IMZ0ezhi85KAPmj3cZfiR6/1w6WjYu+I0ZOYSZ3svtawpiw==
X-Received: by 2002:a19:7017:: with SMTP id h23mr20523075lfc.532.1628553413356;
        Mon, 09 Aug 2021 16:56:53 -0700 (PDT)
Received: from [192.168.2.145] (46-138-117-53.dynamic.spd-mgts.ru. [46.138.117.53])
        by smtp.googlemail.com with ESMTPSA id o8sm951395lft.85.2021.08.09.16.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 16:56:52 -0700 (PDT)
Subject: Re: [PATCH v7 02/37] soc/tegra: pmc: Implement attach_dev() of power
 domain drivers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20210701232728.23591-1-digetx@gmail.com>
 <20210701232728.23591-3-digetx@gmail.com>
 <CAPDyKFrtWDYJo_NjS8306Z9ykbg7XZ55jC9hKEBMGkcrx1=4kQ@mail.gmail.com>
 <1034458d-78e0-5036-e278-6fee5d0d75ac@gmail.com>
 <CAPDyKFoafAk72Kw6X7626Niduaii0V5VM4dGSWmq+e3JTh7VRg@mail.gmail.com>
 <a5dfdf59-f5b5-d28e-6b02-b0c860ba8d80@gmail.com>
 <CAPDyKFq+ExjbGrN=yUUXPKfN_fGrwY6EAYn9a6VUFFU_VjhC=g@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6741262b-386b-7635-fd42-ebd4f877fddd@gmail.com>
Date:   Tue, 10 Aug 2021 02:56:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq+ExjbGrN=yUUXPKfN_fGrwY6EAYn9a6VUFFU_VjhC=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2021 17:15, Ulf Hansson пишет:
>> We did that in a previous versions of this series where drivers were
>> calling devm_tegra_core_dev_init_opp_table() helper during the probe to
>> initialize performance state of the domain. Moving OPP state
>> initialization into central place made drivers cleaner by removing the
>> boilerplate code.
> I am not against doing this in a central place, like $subject patch
> suggests. As a matter of fact, it makes perfect sense to me.
> 
> However, what I am concerned about, is that you require to use genpd
> internal data structures to do it. I think we should try to avoid
> that.

Alright, what do you think about this:

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a934c679e6ce..5faed62075e9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2669,12 +2669,37 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
+	if (pd->default_performance_state) {
+		unsigned int default_pstate;
+
+		ret = pd->default_performance_state(pd, dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to get default performance state for PM domain %s: %d\n",
+				pd->name, ret);
+			goto out;
+		}
+
+		default_pstate = ret;
+
+		if (power_on) {
+			ret = dev_pm_genpd_set_performance_state(dev, default_pstate);
+			if (ret) {
+				dev_err(dev, "failed to set default performance state %u for PM domain %s: %d\n",
+					default_pstate, pd->name, ret);
+				goto out;
+			}
+		} else {
+			dev_gpd_data(dev)->rpm_pstate = default_pstate;
+		}
+	}
+
 	if (power_on) {
 		genpd_lock(pd);
 		ret = genpd_power_on(pd, 0);
 		genpd_unlock(pd);
 	}
 
+out:
 	if (ret)
 		genpd_remove_device(pd, dev);
 
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 81d1f019fa0c..9efb55f52462 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -518,15 +518,14 @@ static const char * const tegra_emc_compats[] = {
  * We retrieve clock rate of the attached device and initialize domain's
  * performance state in accordance to the clock rate.
  */
-static int tegra_pmc_pd_attach_dev(struct generic_pm_domain *genpd,
-				   struct device *dev)
+static int tegra_pmc_genpd_default_perf_state(struct generic_pm_domain *genpd,
+					      struct device *dev)
 {
-	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
 	struct opp_table *opp_table, *pd_opp_table;
 	struct generic_pm_domain *core_genpd;
 	struct dev_pm_opp *opp, *pd_opp;
-	unsigned long rate, state;
 	struct gpd_link *link;
+	unsigned long rate;
 	struct clk *clk;
 	u32 hw_version;
 	int ret;
@@ -633,8 +632,7 @@ static int tegra_pmc_pd_attach_dev(struct generic_pm_domain *genpd,
 	 * RPM-resume of the device.  This means that drivers don't need to
 	 * explicitly initialize performance state.
 	 */
-	state = pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_opp);
-	gpd_data->rpm_pstate = state;
+	ret = pm_genpd_opp_to_performance_state(&core_genpd->dev, pd_opp);
 	dev_pm_opp_put(pd_opp);
 
 put_pd_opp_table:
@@ -1383,7 +1381,7 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 
 	pg->id = id;
 	pg->genpd.name = np->name;
-	pg->genpd.attach_dev = tegra_pmc_pd_attach_dev;
+	pg->genpd.default_performance_state = tegra_pmc_genpd_default_perf_state;
 	pg->genpd.power_off = tegra_genpd_power_off;
 	pg->genpd.power_on = tegra_genpd_power_on;
 	pg->pmc = pmc;
@@ -1500,7 +1498,7 @@ static int tegra_pmc_core_pd_add(struct tegra_pmc *pmc, struct device_node *np)
 		return -ENOMEM;
 
 	genpd->name = np->name;
-	genpd->attach_dev = tegra_pmc_pd_attach_dev;
+	genpd->default_performance_state = tegra_pmc_genpd_default_perf_state;
 	genpd->set_performance_state = tegra_pmc_core_pd_set_performance_state;
 	genpd->opp_to_performance_state = tegra_pmc_core_pd_opp_to_performance_state;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 21a0577305ef..cd4867817ca5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -143,6 +143,8 @@ struct generic_pm_domain {
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
 			   struct device *dev);
+	int (*default_performance_state)(struct generic_pm_domain *domain,
+					 struct device *dev);
 	unsigned int flags;		/* Bit field of configs for genpd */
 	struct genpd_power_state *states;
 	void (*free_states)(struct genpd_power_state *states,

>> I can revert back to the previous variant, although this variant works
>> well too.
> I looked at that code and in that path we end up calling
> dev_pm_opp_set_rate(), after it has initialized the opp table for the
> device.
> 
> Rather than doing the OF parsing above to find out the current state
> for the device, why can't you just call dev_pm_opp_set_rate() to
> initialize a proper vote instead?
> 

For some devices clock rate is either preset by bootloader, or by clk driver, or by assigned-clocks in a device-tree. And then I don't see what's the difference in comparison to initialization for the current rate.

For some devices, like memory controller, we can't just change the clock rate because it's a complex procedure and some boards will use fixed rate, but the power vote still must be initialized.
