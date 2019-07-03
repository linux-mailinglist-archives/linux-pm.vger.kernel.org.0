Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7412F5E158
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfGCJrw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 05:47:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37818 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfGCJrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 05:47:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so943363plb.4
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9bSzX6F1v7RbW0KEIK5WY8e+/zypDBPurorP4G8Usw=;
        b=XGl8hrKVBcbKH3Fp2XKfvFdRkVS67cmLxmp7dRoUTu/2c6t5uoPAcgPPde6VJUIN+4
         EtK8LmyAkg01+yhNCo2nYBRDGXz1IE0t+rsrND/YgYPSpxwmXyxxjVev5nDPFRy05qz2
         dRdXmXkGveWkl2g2Gz76QOHOEB0DSAQilwD1Cfp/RwRDkFPe8bD0c5EgloKu27KD0QRO
         FCMHqVMXWRQj0CKAHG/NsnThWuL4pkLv8Hn5i52sGRAX3NEsO8jEA6A+AcgwQ7EptRK7
         mrd2Ujzn2DHQS5Qb8SOJ1bXj5TBTgaqSVqy7EA+nTKu5YQ5h24PfxCFAtLnKZOZyXp9q
         Fyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9bSzX6F1v7RbW0KEIK5WY8e+/zypDBPurorP4G8Usw=;
        b=QN8x1zMf1PcseaZ2KouXd+WKz11YTHvDUQ1CC2oiCOjMkG63BNtruL5kSi4Ucy0Sqb
         4331We3QWa604qZDy7oOmZ2wvOMHlCyRdVxiko2HTi+Rlt+4vtiWqveluk/twpaPrTpZ
         lknb46KeS+i6jPh6G5xS734Eodv17a54EYDb/GQRS4Tz7KrgXupaBCMRl14ITBMlYKsL
         ImgXm3abRYIPCOvQPqJGH2ochGxPb58P/dBIyTXeICHYGpBt7wDAfVIK5PlbDQ2sOe5a
         QNWvXcXTTT1cIbjdSTGfaxj1EIJhs79RxaIVAxdi5rDT824z2Ki1meRgaUQXqnANoW/P
         W4Ig==
X-Gm-Message-State: APjAAAU7q8qrEMMiNW3z9VImC6EpT/spwofSEnDzANVSKwlSKwj1DPq3
        LuFU8VPOdVA6isEYOQQSIsW29Q==
X-Google-Smtp-Source: APXvYqy46BtNiESHyFgJ1tCsFed1isK+aulCPVW/3DTu5BrP7zjsJaEtMFU/9f6NBPkqohMATlHsSA==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr42014033plz.195.1562147270662;
        Wed, 03 Jul 2019 02:47:50 -0700 (PDT)
Received: from localhost ([122.172.21.205])
        by smtp.gmail.com with ESMTPSA id h6sm1979443pfb.20.2019.07.03.02.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 02:47:48 -0700 (PDT)
Date:   Wed, 3 Jul 2019 15:17:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     vireshk@kernel.org, sboyd@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] opp: Manage empty OPP tables with clk handle
Message-ID: <20190703094746.l354nwp2gwuwhiu4@vireshk-i7>
References: <20190702043643.1746-1-rnayak@codeaurora.org>
 <20190702043643.1746-2-rnayak@codeaurora.org>
 <20190703085026.xe3hwxqah76b7np3@vireshk-i7>
 <95cf4e44-d57a-9aa4-40ce-3b7013e10813@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95cf4e44-d57a-9aa4-40ce-3b7013e10813@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-07-19, 14:41, Rajendra Nayak wrote:
> []..
> > 
> > Explain the rationale behind this code here in a comment.
> > 
> > > +	if (!_get_opp_count(opp_table)) {
> > > +		ret = _generic_set_opp_clk_only(dev, clk, freq);
> > > +		goto put_opp_table;
> > > +	}
> > > +
> > >   	temp_freq = old_freq;
> > >   	old_opp = _find_freq_ceil(opp_table, &temp_freq);
> > >   	if (IS_ERR(old_opp)) {
> > 
> > Also, rebase over the OPP branch please:
> 
> thanks, I will fix/rebase and repost,
> in the meantime while I was testing this a little more I realized I also need
> something like the change below to avoid a refcount mismatch WARN when empty OPP
> table is removed using dev_pm_opp_of_remove_table()
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index fa7d4d6d37b3..20128a88baf2 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2118,7 +2118,8 @@ void _dev_pm_opp_find_and_remove_table(struct device *dev)
>                 return;
>         }
> -       _put_opp_list_kref(opp_table);
> +       if (_get_opp_count(opp_table))
> +               _put_opp_list_kref(opp_table);
>         /* Drop reference taken by _find_opp_table() */
>         dev_pm_opp_put_opp_table(opp_table);
> 
> Does this look like a good way to fix it?

No. If an OPP table only has dynamic OPPs, this will still generate
warning. Below is the fix I would suggest. Please test it, I haven't
tested it at all :)

-- 
viresh

-------------------------8<-------------------------
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 3 Jul 2019 15:03:14 +0530
Subject: [PATCH] opp: Don't decrement uninitialized list_kref

The list_kref was added for static OPPs and to track their users. The
kref is initialized while the static OPPs are added, but removed
unconditionally even if the static OPPs were never added. This causes
refcount mismatch warnings currently.

Fix that by always initializing the kref when the OPP table is first
initialized. The refcount is later incremented only for the second user
onwards.

Fixes: d0e8ae6c26da ("OPP: Create separate kref for static OPPs list")
Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c |  1 +
 drivers/opp/of.c   | 21 ++++-----------------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 89ec6aa220cf..2958cc7bbb58 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -943,6 +943,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
 	kref_init(&opp_table->kref);
+	kref_init(&opp_table->list_kref);
 
 	/* Secure the device table modification */
 	list_add(&opp_table->node, &opp_tables);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a637f30552a3..bf62b357437c 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -665,8 +665,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 		return 0;
 	}
 
-	kref_init(&opp_table->list_kref);
-
 	/* We have opp-table node now, iterate over it and add OPPs */
 	for_each_available_child_of_node(opp_table->np, np) {
 		opp = _opp_add_static_v2(opp_table, dev, np);
@@ -675,17 +673,15 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 			dev_err(dev, "%s: Failed to add OPP, %d\n", __func__,
 				ret);
 			of_node_put(np);
-			goto put_list_kref;
+			return ret;
 		} else if (opp) {
 			count++;
 		}
 	}
 
 	/* There should be one of more OPP defined */
-	if (WARN_ON(!count)) {
-		ret = -ENOENT;
-		goto put_list_kref;
-	}
+	if (WARN_ON(!count))
+		return -ENOENT;
 
 	list_for_each_entry(opp, &opp_table->opp_list, node)
 		pstate_count += !!opp->pstate;
@@ -694,8 +690,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	if (pstate_count && pstate_count != count) {
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
-		ret = -ENOENT;
-		goto put_list_kref;
+		return -ENOENT;
 	}
 
 	if (pstate_count)
@@ -704,11 +699,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
 	opp_table->parsed_static_opps = true;
 
 	return 0;
-
-put_list_kref:
-	_put_opp_list_kref(opp_table);
-
-	return ret;
 }
 
 /* Initializes OPP tables based on old-deprecated bindings */
@@ -734,8 +724,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		return -EINVAL;
 	}
 
-	kref_init(&opp_table->list_kref);
-
 	val = prop->value;
 	while (nr) {
 		unsigned long freq = be32_to_cpup(val++) * 1000;
@@ -745,7 +733,6 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
 				__func__, freq, ret);
-			_put_opp_list_kref(opp_table);
 			return ret;
 		}
 		nr -= 2;
