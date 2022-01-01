Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427F348278B
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jan 2022 13:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiAAMPS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Jan 2022 07:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAAMPS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jan 2022 07:15:18 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E7CC061574
        for <linux-pm@vger.kernel.org>; Sat,  1 Jan 2022 04:15:18 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id m1so25542809pfk.8
        for <linux-pm@vger.kernel.org>; Sat, 01 Jan 2022 04:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=bjDmQ/WT0IfFsyLwiE8LE8KaIIdqQZprPPb5YyDclKqtvz6nod8LDdvTIOQoTYpClu
         8rfSf/gFOu+PiB0nC18yCoG9k95XlotqvneoNoVZvI5KtHwhGEppHPJAceSUKSE22YjZ
         PvrcS6cW8FpgiU5CKZgg8F3AYrCctzWNa5Mgl6GXzU79nruZGth0alx+h4vHZQUJp2xZ
         otB4l88/cLz14L0/gPW0T63TEWDVFnpp34au7Ci6ErOrbYT9EHD9yCTUSAVeSTsEYv7J
         cdeWhZt8q10YIDBJNR9CUcUuFjzPQcPkQTjLbfsdAw0H5zIs4sqPlEjx5HYFTnKIhTVt
         XUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=7APKzDuMRul20eyGFYwp7343C9yORYA37bSP3A0e2x+slCDw5dYA8TB1bViStJ/uo3
         1J7krRhcNIQOziBNWYpMaaZNFM+JMMaEShpcvTuo+q/ApSurm7OuiWH6hJGIuvPXmubZ
         sKL+g/Adx9FPcdz0aCLdRrDl6oHyEvoWticN/zpWHAgqK3ejYVP7/X1KRrie4uRQJqBn
         VAxgY4qf9ukYyMXAjhS7cGObpJXWzpjzaha32dnP1WHYISc4++xfMZS86c8cUbAtjWXj
         419wPJ+90tm+CN8IIXP+sNCKHgMEjBJc2KhUFrRDgvus2CvKkIY9tn7HpPTnae+krZln
         mlHw==
X-Gm-Message-State: AOAM5303GVvpP4U5oUt5nvzl06dmzZQ8ABgwaa9uclr0ZXkcmuLyEtVE
        Sn/FrTzMjpDEzXDOZX5vSzU=
X-Google-Smtp-Source: ABdhPJyUNYe2qoM/po3LhVM/uoNGxHtoNoVp9ptJJUJoU/DMv7ZUEBdDgju5NGOWXpL7j54pFCosyg==
X-Received: by 2002:aa7:91c3:0:b0:4b0:eebe:49c0 with SMTP id z3-20020aa791c3000000b004b0eebe49c0mr39433341pfa.6.1641039317710;
        Sat, 01 Jan 2022 04:15:17 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id c7sm33483169pjs.17.2022.01.01.04.15.09
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:15:17 -0800 (PST)
Message-ID: <61d045d5.1c69fb81.5385d.d709@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:15:01 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

