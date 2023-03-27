Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4356CA5CD
	for <lists+linux-pm@lfdr.de>; Mon, 27 Mar 2023 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbjC0N2b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Mar 2023 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjC0N2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Mar 2023 09:28:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699FD6195
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 06:27:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so36251265edb.4
        for <linux-pm@vger.kernel.org>; Mon, 27 Mar 2023 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679923637;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT1ntTJRA7Dyw6CsoaeXlaJ9ZTEdJhQliPCqlBPEyeY=;
        b=a1S8bccoMC6dQICPc0w92OaI13xGnF+A4hr9UqjI9y3MsbGEo2VtrlM4AyvcOlOx+r
         m93BNyceXauxvr/gAXZ6wAiKwGxIIon8gnGlBRpGhc17nyWTkCcJEufWZT7fJp6BEe7B
         +Zr5uKHuXMN3XUa4qEcwYL9SsxDh2wSKhXP6EEOJBB6/iJecwg8lNQfpaJ1assLA7SKz
         epWtBe2YVXsjtnu3uo0rEntEFGDndXRUOBpl8FQ6q7Fxf447G+Q86J4tBDmbp0tUYNx9
         rcF0Yh0IWujESls+Az76/H/7vJqmlNBMW2fQhYaAL56elUsDcn7e5kjtZpNMI3mnoTFy
         4ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679923637;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UT1ntTJRA7Dyw6CsoaeXlaJ9ZTEdJhQliPCqlBPEyeY=;
        b=NWebomfwyD41BfuLxFUNlGo2e/Z5hzN1R4AvjJQNl3VE/WD8CV/Fu7VxlDkt3uaEU4
         IhunOZzkvZnoNAhn2tfWBmHx6TMQhw+dQhKZebf0L3fW+pS++FR0FlCOetnm8zZMVIPF
         xDJsErEUdn2LE/VIfkEtRui3DggBCANtxQC4juspuN35sX5qhxnme70St4a1xIa9EEGl
         1+qgRg+LxAXo7xA4ZaN6/bnDRdW9e5XYT3pHQ7fCxMD00HKfBvFQDbCLvl5Qn+cUe/7W
         orn2JSFZBr9NeNSyzn2uA3fhemAQ91T9dz2Sgdu81QahHclhr4KhA1lSS7F9auFUyvf+
         eigw==
X-Gm-Message-State: AAQBX9fwIXQ/jVatAzYch9YEquizo3T7KcVR/Cukyf/2qmUj+Ws9VWvg
        WxuHm57yfpsv+gexGvN4jtYoDsgQw0UbZEgMXFA=
X-Google-Smtp-Source: AKy350baNvStlVmD5goYzdG+Sl6fLjgtDvY5z7YClpHBjGHBlWQPobxEwgpBpHgBbiR8sxVErPS+hw8ObENB7Y4UwRQ=
X-Received: by 2002:a17:906:7846:b0:933:1967:a984 with SMTP id
 p6-20020a170906784600b009331967a984mr5532759ejm.15.1679923636807; Mon, 27 Mar
 2023 06:27:16 -0700 (PDT)
MIME-Version: 1.0
Sender: fdarpino19@gmail.com
Received: by 2002:a54:3788:0:b0:207:eb4:9c09 with HTTP; Mon, 27 Mar 2023
 06:27:16 -0700 (PDT)
From:   Jeffery Serge <jefferyserge00@gmail.com>
Date:   Mon, 27 Mar 2023 13:27:16 +0000
X-Google-Sender-Auth: SBMMNmKrdYBBwLZ6YFW_cGW8Vws
Message-ID: <CAErfpoQZ8iUtG8hjVWoLAnH=RDWMJstqVdB9tW3M5tfrbaBUDA@mail.gmail.com>
Subject: Re: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        LOTS_OF_MONEY,MONEY_FRAUD_5,NA_DOLLARS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I am Mr. Jeffery Serge, the Bank Accountant manager. First I will like
to apologize for intruding  into your privacy, since we don't know
each other. Understand my reason  of contacting you. I wish to have
you as my best friend and also a business partner. I have a legal
business proposal worth $7.500,000 million U.S dollar with mutual
interest of 50/50.
