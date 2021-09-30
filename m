Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D4D41D4E8
	for <lists+linux-pm@lfdr.de>; Thu, 30 Sep 2021 09:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbhI3IAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Sep 2021 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348701AbhI3IAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Sep 2021 04:00:33 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177B7C06161C
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 00:58:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s20so6442750ioa.4
        for <linux-pm@vger.kernel.org>; Thu, 30 Sep 2021 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kfDlQBVSqf07hAXhTAUKnH/OI2lCXLrpWHu75WLFvTA=;
        b=BN2r9KCsiTHABZYxMKEi6uJAuuYtVovNQVmPfRFjDnJh/h8yIXJ7VBgBoKaslnuMqG
         acPxORut2GBAr1COV7abybytzbbEvU+r2kixJgMXqSrU3LUVISpMScYlkfqe5PJjoRLm
         DJ1ksOq/BE0gVpEK/zVpOlNxYdBM6a6YcrQCyHQHUSjUDmPxHqwOjuTnzz4WuPKVZGSa
         HKlACQTBzxIcFkrn0s86GvAIpmxsOjFSms4SZZRJ+Wpxi11Q57Q/hTHgWetKNt27qLP2
         WxzYj2Zw6GCWYfvpuG83uIYN9JleXmq05I/S2D3Ea5mlVzgOIlfA6MDU/uqqAK3jC8gO
         Ap9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kfDlQBVSqf07hAXhTAUKnH/OI2lCXLrpWHu75WLFvTA=;
        b=hspVZs2wAN36K2uG7bQHP//TkJLBtW8B+i4XfRLcUk5tXzqA4tWrcjfywG5MX/AE73
         gFMs9Cp+SwBYxUrIkwUblDq25RoLZvIFD58hvsH1+oZOvGgJzI6XoraNgn0R3+cq3xEJ
         3nrQH1SezcgEZz0EkkPZTXMbizutFtVaIBx6zkJvWwuk0i+cIgFmJ470WIVHmrceLfpi
         n1xcldzL4Rh1Jj9FOv9aldX9v/roMsk9C4M4NBJ6F+G/GjiX3upquRp1f7HMxRDfCImT
         zswNeHAOI4loMHSpSMpgVUFY2mjB5khY1Lfsf2bUzAaUAkjIaEjBc/FDgD9NRp04tntD
         SDDA==
X-Gm-Message-State: AOAM530d1UyxDrHPGuboUgaXzHGCmV8lF7HO/C6bzIMlplwMKU9dzS85
        hrFTBMwrWrRdSO0fHZlQaYceSW9mo9nBiAuUrtA=
X-Google-Smtp-Source: ABdhPJzUEf+cnGPTlNNwvJEf8Aw0C9Lm01k8OE2dFnTU44GznXekNNzejHRrFmvggguh794n3Ku3nRYeZEflRNgSgfE=
X-Received: by 2002:a05:6602:20d3:: with SMTP id 19mr3001038ioz.86.1632988729990;
 Thu, 30 Sep 2021 00:58:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:b281:0:0:0:0:0 with HTTP; Thu, 30 Sep 2021 00:58:49
 -0700 (PDT)
Reply-To: justinseydou@gmail.com
From:   Justin Seydou <felixfernando.6500@gmail.com>
Date:   Thu, 30 Sep 2021 08:58:49 +0100
Message-ID: <CAA6riO1gS0nN9rH-mdPCwzBeD9Xx0Z5RBpi1SDFUXs75yDkoNQ@mail.gmail.com>
Subject: =?UTF-8?B?15TXptei15QvUHJvcG9zYWw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15fXkdeoINeZ16fXqCwNCg0K15DXoNeZINeb15XXqteRINeb15PXmSDXnNeU15XXk9eZ16Ig4oCL
4oCL15zXmiDXotecINeU16bXoteUINei16HXp9eZ16og16nXmdepINec15kg15HXlCDXlNeZ15nX
qteZINeo15XXpteUINec15jXpNecINeQ15nXqteaLg0K157Xk9eV15HXqCDXkdeX157Xmdep15nX
nSDXnteZ15zXmdeV158g15PXldec16guINeU15nXlCDXodee15XXmiDXldeR15jXldeXINep15TX
m9ecINeX15XXp9eZINeV15zXnNeQINeh15nXm9eV16DXmdedLg0K15DXoNeQINem15nXmdefINeQ
16og15TXqtei16DXmdeZ16DXldeq15ouDQoNCtee15nXmden15wg16jXkNeX15nXky4NCg0KDQpE
ZWFyIGZyaWVuZCwNCg0KSSB3cml0ZSB0byBpbmZvcm0geW91IGFib3V0IGEgYnVzaW5lc3MgcHJv
cG9zYWwgSSBoYXZlIHdoaWNoIEkgd291bGQNCmxpa2UgdG8gaGFuZGxlIHdpdGggeW91Lg0KRmlm
dHkgbWlsbGlvbiBkb2xsYXJzIGlzIGludm9sdmVkLiBCZSByZXN0IGFzc3VyZWQgdGhhdCBldmVy
eXRoaW5nIGlzDQpsZWdhbCBhbmQgcmlzayBmcmVlLg0KS2luZGx5IGluZGljYXRlIHlvdXIgaW50
ZXJlc3QuDQoNCk1pY2hhZWwgUmFjaGlkLg0K
