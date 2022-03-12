Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348074D7050
	for <lists+linux-pm@lfdr.de>; Sat, 12 Mar 2022 19:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiCLSJO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Mar 2022 13:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiCLSJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Mar 2022 13:09:13 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B775230
        for <linux-pm@vger.kernel.org>; Sat, 12 Mar 2022 10:08:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so9450128wmj.0
        for <linux-pm@vger.kernel.org>; Sat, 12 Mar 2022 10:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=PZ2J6F7b9xENKNRz7G3Duz9NjkVPjppLErUrSJ5LZwqNgdcF3PhwLRWlBLTg0NBuxS
         XerSDCSm92mkPBuOsGO8irWPHUjlUjzRKWTmIzRg9jQgBtt511SeD2OrRPfvHcvnC7yr
         UW9vC2j7oJu/T4pt98eauHAgSaseOeFLzkn7biR2kPGaebV46Tl1f/2HwpK5IT+ORaa+
         1TOUvYcnghdk+btvODSX4Xelg0UTIOxv8rEdCdz0tCCGGE/JoSByKtOn7dF+642BehOO
         4ZZdcKJUfls5SWaGPyGP9pKB8cojA1o1aN4fDS07euOy1XhS78gWKAz9XFyE9cJF8gSH
         Obnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=pgT3tufSH9aUJRoutgynxRJoL3DijGQ0KHsG1S1zUq43vRFMyY80nNDccqK0j1U5rL
         zunDBUPiRLHKJo4Ww9k2VPeCs74PPp6Q6cdxKUEaddeqevQ/tZEZkdr6NFS56RzgfNWI
         Oz+Qymrd4ch2dyg4q5YQ1SiSkNQXtBW+RlwlllIB1O6xr3SENsDJRYHBOscfQfK5nzmt
         RK5jan0k4B6lkBE/+54FqYO3P2RJuwpDlOsnvxt4AENQSouiLDgJi+3nvpESmN98BOxM
         shMNTwiTqUY+1cykT4RZHx6qLNlbCqzW4jIoZj+fGRhuVJfasWyz2g+zNZY47heEO8+H
         p1lQ==
X-Gm-Message-State: AOAM5336V68mn8oI+Ljwei7lnf5z0/WPzcPyLrt/svUPMGV/g2wJKGUM
        U/TktV9DdYuMtqy80+mc/nY=
X-Google-Smtp-Source: ABdhPJzZX1RcZQInJPb1HF2VlB+0kx0nZsFp0meB2w5DcbAgQ3xP7nOyiVeXdagj+/lcwEQdIeIHzg==
X-Received: by 2002:a1c:6a1a:0:b0:387:5ee7:750e with SMTP id f26-20020a1c6a1a000000b003875ee7750emr11809286wmc.85.1647108484153;
        Sat, 12 Mar 2022 10:08:04 -0800 (PST)
Received: from DESKTOP-26CLNVD.localdomain ([197.210.71.145])
        by smtp.gmail.com with ESMTPSA id h36-20020a05600c49a400b00382aa0b1619sm9860008wmp.45.2022.03.12.10.07.59
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 12 Mar 2022 10:08:03 -0800 (PST)
Message-ID: <622ce183.1c69fb81.128f8.7da8@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <yauiliyasu019@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler  <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <info@gmail.com>
Date:   Sat, 12 Mar 2022 10:07:55 -0800
Reply-To: mariaelisabethschaeffler88@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich lesen

https://www.forbes.com/profile/maria-elisabeth-schaeffler-thumann/#443b4a6e=
19c7

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email:mariaelisabethschaeffler88@gmail.com

