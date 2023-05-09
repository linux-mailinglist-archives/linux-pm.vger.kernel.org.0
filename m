Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8B6FBE26
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 06:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEIETx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 00:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjEIETx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 00:19:53 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D6644B6
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 21:19:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so27759985e9.1
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683605990; x=1686197990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85Q1NaGGe8OW9kxKt5Dbimk7jitWhTHBqF9ciAkJJzE=;
        b=NELHYvdWb4txNkBqg3k4ahgu1la2hkzbvfejsE/dYd/nTIEsMBo5sOqlA5ZVDqQRea
         BKWtQGCWnC7WcM2fWKanRU/YXfkWwt6YP3RFcriAOGrJUp9eHGj+Ta2570AJahsbLHkV
         qbIO2aSteRqzLnUImUaxHILS+6VGehCJcmiuzihWLtWg402iRiGnx2j7fcrsp7gltejR
         /pEpNGYPkHCfZ07y5aJKYhzf6bSAsizSWZCKOkRZiSw9WemxgZzcYc23UYkknkwkq4EA
         iotp4MkWisZjG1a6zihcCroc3rofjeF30Kth7OviUwdgQjA5MBwD7dhYSfYxLNpkz8pu
         3EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683605990; x=1686197990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Q1NaGGe8OW9kxKt5Dbimk7jitWhTHBqF9ciAkJJzE=;
        b=davfRsGt5W86pcuxaDECJsGndkSq9SrxG9zp8Q9HCIz5AAWqkH8nkQ2X0+3kazPdBL
         gl2sI7YNLukZUY9tvylmtdtlJ7blw80Z7YYCg7vERkk03ESjCALYFYM1hVhhhC+SkAwM
         yTkVCGjbPe4L1/GQHEiXjsvTFXcnH92yfBAGef4U7XDkBBhMC4UGwluCGFlgsa+H1L0v
         lQy5lhXq3lvJgVQqSHgtnB+QcBB7xwwWhlPb3TOcYqSNMVkbmvJ2bwLBnmrDollElRmT
         QdJAAISxGSGOGzTOHXUuDOONsEqOelJMuBQ6mp00CfpQDg63/38ooqO6b1/hoDo1dZPt
         RLRQ==
X-Gm-Message-State: AC+VfDzHjgB+FVR5uDLKk3OJmXtjXpriLzXV0kP7aMocBSRSG5KGbCmt
        LKSg+3oOYliTb6FAX66I31xcGXSYhbWzDj8IOL8=
X-Google-Smtp-Source: ACHHUZ4f6NRz82dvXw/shSO8297o6GC+T4s0d20NvwtHdoU6+x21AMlcOWMguvVqL+D1pyUc9m668A==
X-Received: by 2002:a7b:c404:0:b0:3f1:6942:e024 with SMTP id k4-20020a7bc404000000b003f16942e024mr8940980wmi.27.1683605990044;
        Mon, 08 May 2023 21:19:50 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b003f1738d0d13sm521021wms.1.2023.05.08.21.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 21:19:48 -0700 (PDT)
Date:   Tue, 9 May 2023 07:19:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] power: supply: Add charger driver for Rockchip RK817
Message-ID: <7ffee6ca-00fb-4fdb-8741-8f9163bfa75b@kili.mountain>
References: <dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain>
 <SN6PR06MB534254918F9D84F996BFD2ACA5719@SN6PR06MB5342.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR06MB534254918F9D84F996BFD2ACA5719@SN6PR06MB5342.namprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 08, 2023 at 01:46:53PM -0500, Chris Morgan wrote:
> On Thu, May 04, 2023 at 01:58:31PM +0300, Dan Carpenter wrote:
> > Hello Chris Morgan,
> > 
> > The patch 11cb8da0189b: "power: supply: Add charger driver for
> > Rockchip RK817" from Aug 26, 2022, leads to the following Smatch
> > static checker warning:
> > 
> > drivers/power/supply/rk817_charger.c:1198 rk817_charger_probe()
> > warn: inconsistent refcounting 'node->kobj.kref.refcount.refs.counter':
> >   inc on: 1088,1105,1115,1124,1130,1136,1146,1160,1166,1170,1177,1186,1193
> >   dec on: 1067
> > 
> > drivers/power/supply/rk817_charger.c
> >     1048 static int rk817_charger_probe(struct platform_device *pdev)
> >     1049 {
> >     1050         struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
> >     1051         struct rk817_charger *charger;
> >     1052         struct device_node *node;
> >     1053         struct power_supply_battery_info *bat_info;
> >     1054         struct device *dev = &pdev->dev;
> >     1055         struct power_supply_config pscfg = {};
> >     1056         int plugin_irq, plugout_irq;
> >     1057         int of_value;
> >     1058         int ret;
> >     1059 
> >     1060         node = of_get_child_by_name(dev->parent->of_node, "charger");
> >     1061         if (!node)
> >     1062                 return -ENODEV;
> >     1063 
> >     1064         charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> >     1065         if (!charger) {
> >     1066                 of_node_put(node);
> > 
> > This error path calls of_node_put() but probably they all should.
> 
> Thank you for pointing this out. So I should probably just add a "goto"
> that puts the node at the end, and direct every error to this? Just
> want to confirm.
> 

Yes, please.

regards,
dan carpenter

