Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1CF55B7E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 00:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfFYWqi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 18:46:38 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58438 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFYWqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 18:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561502796; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NcmE0IdPIHPsGxWgeHnGaPovtko75TEzGChEKas55B4=;
        b=oQ8txPHBXprhG3RY+xYXhM1fXk33OBrHHN986T//ux3X+VqX1jC9KgRhoORObmKVElmqgY
        Grpv4WwuEC9b/Ej3Fjozh9dDFcmiZkppvZ1T+4jTnn8eK0+MNhpC4K3eOBemWja2w+heWI
        i5TFA+Kc38rwaz+R7v3l5bszY1VshWg=
Date:   Wed, 26 Jun 2019 00:46:31 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/5] clk: ingenic: Add missing header in cgu.h
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, od@zcrc.me,
        linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <1561502791.10069.2@crapouillou.net>
In-Reply-To: <20190625224221.2643520645@mail.kernel.org>
References: <20190611180757.32299-1-paul@crapouillou.net>
        <20190625221736.853892086D@mail.kernel.org>
        <20190625224221.2643520645@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Le mer. 26 juin 2019 =E0 0:42, Stephen Boyd <sboyd@kernel.org> a =E9crit :
> Quoting Stephen Boyd (2019-06-25 15:17:35)
>>  Quoting Paul Cercueil (2019-06-11 11:07:53)
>>  > The cgu.h has structures that contain 'clk_onecell_data' and=20
>> 'clk_hw'
>>  > structures (no pointers), so the <linux/clk-provider.h> header=20
>> should be
>>  > included.
>>  >
>>  > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  > ---
>>  >
>>  > Notes:
>>  >     v2: Rebase on v5.2-rc4
>>=20
>>  You seemed to miss my review comments on patch set #1.
>>=20
>> =20
>> https://lkml.kernel.org/r/155726035790.14659.7321778387595703949@swboyd.=
mtv.corp.google.com

Oops. Sorry about that.

> I've just decided to fix it instead of wait. Let me know if that's a
> problem.

Sure, that's no problem. Thanks!

-Paul

=

