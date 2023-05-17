Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633737065B0
	for <lists+linux-pm@lfdr.de>; Wed, 17 May 2023 12:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjEQKxQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 May 2023 06:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjEQKxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2023 06:53:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759EE6A5B
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 03:52:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso4262465e9.1
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2023 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684320749; x=1686912749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VugH1tQ7vZZoBJJRLnlUhL4w8lPaFFIY1yDqNGRu4yw=;
        b=wCdjCadGLvzpiSCyarcUg1qmdHQFNq+aQjhUkXRx3cjECD1XoYYxyw5lDue34F/2oG
         5mt5RHopYknMCMs3uY8OSOWAgnKapXfRykb9BvmxhqOsg8qcVs/uhe2PXgVZygOOoREE
         fLZYRHnDRzUu6WviEPxRpXXX/rnGhMXtjf1XSfZnuZq3kZtkdwZIVhbhyg1klltmHWU9
         YMg2K5/MT9Eh+flJmdrRzvQth9z/3Uev0tTA8SL2zjPxynH50PlkGuNvu/A80XeKTTuW
         JhfYeXnLCdtonuN7MB4o2BcEEgS/yM5UA8BjpATGECoaijVTvnwmaXsq2AVkfGP/m6Yz
         UmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684320749; x=1686912749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VugH1tQ7vZZoBJJRLnlUhL4w8lPaFFIY1yDqNGRu4yw=;
        b=QkN5Dex1Ts5T19fRkLU1jmh0QHYxvTA9YQDDi+LkeQQ6RJpwxOSTbykG5YSfDL+Lac
         uL5cBqO7aiZPd2AYBFMMzaB653lreu9ucFVy1Nbhitnc9aeGdHSLo+cefAxnUB+0W9Ki
         LhN7OMquWSaTiM4WlS/ppXJ/JkVNK3MwU12zwZsCq5IiaB7wwc4LqqXH3Yak6D897wst
         g594JjifOuWxmxLX7X2QV4V7MxjbAljRMM5K2Mg8rsW05cnl+BhKPgaZscqNrg6YD2Sv
         STLuqhWv75h9lyg941bQfoBe23n0dfMNPA9m9Lkzhak+mWtq88vPSmT0xAbmHsBbtjyG
         TnRA==
X-Gm-Message-State: AC+VfDzbVs1Vt10h0Bfhjzo5zdtszA5xd+NJWxStjhJJGRH0nJibRSIF
        AVAaE+NGICJGM8jyKm8bUglKIx4tCWAVTKtPfWk=
X-Google-Smtp-Source: ACHHUZ6/eZAHqWfMyeQrdGHHJ4zAEN85Gxb6UGFw22/zA/Et2qAkmv1qDg7AMrdDXcDUQdgfxYEBjA==
X-Received: by 2002:a05:600c:2059:b0:3f4:2492:a91f with SMTP id p25-20020a05600c205900b003f42492a91fmr24048239wmg.27.1684320749285;
        Wed, 17 May 2023 03:52:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z23-20020a7bc7d7000000b003f1957ace1fsm1862261wmk.13.2023.05.17.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:52:27 -0700 (PDT)
Date:   Wed, 17 May 2023 13:52:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] power: supply: Add charger driver for Rockchip RK817
Message-ID: <fa8e551c-ee7e-4f35-8592-7c9b4f4ccbd5@kili.mountain>
References: <dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain>
 <SN6PR06MB534254918F9D84F996BFD2ACA5719@SN6PR06MB5342.namprd06.prod.outlook.com>
 <7ffee6ca-00fb-4fdb-8741-8f9163bfa75b@kili.mountain>
 <SN6PR06MB53428AF7C7CB29DD6EE243FAA5789@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR06MB53428AF7C7CB29DD6EE243FAA5789@SN6PR06MB5342.namprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 15, 2023 at 11:49:07AM -0500, Chris Morgan wrote:
> On Tue, May 09, 2023 at 07:19:44AM +0300, Dan Carpenter wrote:
> > On Mon, May 08, 2023 at 01:46:53PM -0500, Chris Morgan wrote:
> > > On Thu, May 04, 2023 at 01:58:31PM +0300, Dan Carpenter wrote:
> > > > Hello Chris Morgan,
> > > > 
> > > > The patch 11cb8da0189b: "power: supply: Add charger driver for
> > > > Rockchip RK817" from Aug 26, 2022, leads to the following Smatch
> > > > static checker warning:
> > > > 
> > > > drivers/power/supply/rk817_charger.c:1198 rk817_charger_probe()
> > > > warn: inconsistent refcounting 'node->kobj.kref.refcount.refs.counter':
> > > >   inc on: 1088,1105,1115,1124,1130,1136,1146,1160,1166,1170,1177,1186,1193
> > > >   dec on: 1067
> > > > 
> > > > drivers/power/supply/rk817_charger.c
> > > >     1048 static int rk817_charger_probe(struct platform_device *pdev)
> > > >     1049 {
> > > >     1050         struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
> > > >     1051         struct rk817_charger *charger;
> > > >     1052         struct device_node *node;
> > > >     1053         struct power_supply_battery_info *bat_info;
> > > >     1054         struct device *dev = &pdev->dev;
> > > >     1055         struct power_supply_config pscfg = {};
> > > >     1056         int plugin_irq, plugout_irq;
> > > >     1057         int of_value;
> > > >     1058         int ret;
> > > >     1059 
> > > >     1060         node = of_get_child_by_name(dev->parent->of_node, "charger");
> > > >     1061         if (!node)
> > > >     1062                 return -ENODEV;
> > > >     1063 
> > > >     1064         charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> > > >     1065         if (!charger) {
> > > >     1066                 of_node_put(node);
> > > > 
> > > > This error path calls of_node_put() but probably they all should.
> > > 
> > > Thank you for pointing this out. So I should probably just add a "goto"
> > > that puts the node at the end, and direct every error to this? Just
> > > want to confirm.
> > > 
> > 
> > Yes, please.
> > 
> > regards,
> > dan carpenter
> > 
> 
> Would it be possible to get details on how the error was generated with smatch?
> I tried based on the instructions from https://smatch.sourceforge.net/ but I
> was not able to generate the error prior to attempting my fix. For my fix I
> was just going to do an of_node_put(node) right after I set
> `pscfg.of_node = node` and I want to make sure that solves the problem.
> 
> Thank you.

Hi Chris,

This warning relies on the cross function DB.  It's not hard to build
the cross function DB, but it just takes like 8 hours or something.
	smatch_scripts/build_kernel_data.sh

Your patch would silence the warning, but I had assumed we would want to
hold the reference for the lifetime of the driver...

regards,
dan carpenter



