Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BDE1CF387
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgELLlV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 07:41:21 -0400
Received: from mout.web.de ([217.72.192.78]:53177 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgELLlV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 May 2020 07:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1589283660;
        bh=A+4xEyEwZKXYezjnPWr+qg/gcElrcDOJ0XA+qR0Nbvc=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=Pr+YL81UIty3FpX1jV65A6XwyoHywg3HZdQge8ilxlSMS91Gcte3MRvhJOIODJIA/
         Ns7qH0925J4T7IMtd9mfJJhQG/ZEAxb8hRt/C3iD4ODYKdCgHdpvaYKGpoYwoLE2qU
         lWJgt/+HlRpKX2H4yYBElu8eeP+s8KYq3KMpiqnk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.36.232]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnB9V-1itvKj2Nx7-00hJOx; Tue, 12
 May 2020 13:41:00 +0200
Cc:     linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2] memory/samsung: reduce unnecessary mutex lock area
To:     Bernard Zhao <bernard@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <edf839ce-cc61-73dc-e017-b49648b94d1c@web.de>
Date:   Tue, 12 May 2020 13:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nr0aRieGx1rEENbBLBwLoDX+QXFqpgLMLhbkMbn4ANo3yd24ccF
 CQM58RfOOMMoju9fJMifKnCzr68v6+tpQaLGhSGPF9six/LniCwhCdayPYMCnXGWclRdt4A
 mtVW6eHWTdz2WBlfQplX4ItxEEnU6dngi1y2qOWqw48lU/07Ze9pwjPoYsKp0BHuZ8m2A1V
 tz1YINJ2UOKxEKfjbWbiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gogZXhDZGJQ=:pU28Sia5hIOMKCWyNsloQ/
 eCuMncCaD9NAKf4iYHNxjniUZiqYWmjnyAiXrO1bDoBjvzpgNgzsbIMdOXcFPHzeNdSOISpNU
 6aL6HaE4BRsPOpb7Tt2wpNJtyp8WNcd8PbujqcYHdlBw2QZ/KWj2TP9U0aM/ooqStpE8mkaB/
 OTFCHgdAW75Bj9Y3x7glwKKQSUWK9ziETUV+1/t5FYVdX3kdhYPFz5GxP4+VRVK9aAnHwD96h
 8YCNxv2Vd+v9W0MEfiraxv1UTQtlowsk+mlMWA/i+CI4Kc00aMU8QDG5KptNJVdob+KeYlmuI
 dFB72gufxZy8RYXCAVTGU6+oiErneGImwAHuk/TxUPbwALJInK9nQfWuUcZUfbkanNPGTdvG8
 dfiZhRnVUMIwnERF6WCVDD6fv1SLGdo9G9Am/LzEBqPW/TVqCyDc0H6mJpeZaK4unPSnNFjTF
 F6qmUI90Bem8ug1CU2oriQZwEU3zr3/zwOIs2H3wqVA6LxepQR5HcvxotRV/vQ+QQ2pFubkXI
 LUWqquqOCzZXw/NjK6A1mCg2kyJLPId0rOhXW40uNRa/UI7IdGV5UMIWRIsrF4AfnZFSRBKVi
 TTPRprK+4HINxIzyeH1qPGgWPPEQT0F1H5Tx5pHqhn0yzuQd/fyGKnw0wC5uMnaNRcV2lqGUH
 790MYgCkf/dXGRjY4hHB5+R5kjOGkAulzNr1+rkfi8tq8/PzPt/y9IOHe2cOr7sAgT8U2Ic8Z
 en+W2NGHJCjamJl5PP5hGPGX1wCftQaJNPsfWREaEbJ5ZzyyVFvH05qSTyjF9RQp//byIs3tB
 Ho5GlFyC/PLXWXbtdHJGm5/bbijJY8zvTXsuzuTWu0/edIJOP0xC6W7gs6LJWqCaPvXSiVEKH
 hBC3/VrhvJ2buGmObgbZkR2qa9TKbuKeMtpK/e5y7eR+nwiBCIiIJyay5kB4wn/c5Wj3vUQfr
 c0jYjmVsU1kzmnntQGViVRc/02GcSeU7fMKC2Zz+HnP29XTcHPY6SQ01eaT0zbnrik29oOQzq
 X7PQ+25oXCpW9/94I2f82FqNpDVk2DhZkdcfvpWMOzV7FsLYoCzoCjKjfHqC5PpDLzIzlT/yE
 yj79nSDgD8X0l5/QRLZLYQRb+nh5dJXW8koUtM+svIlrpctop8OBUqJTRKP6XIBVuctkBx8Xg
 WSCftCupU7rXM3Wn/LCLWcy6g6Rj7NytfLXhriRF5XSrsGqpi/iAOps1EvVrVv+RmURHUETrF
 RxsCZSq9VQLj/0Gfk
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Maybe dmc->df->lock seems not needed to protect "if (ret)
> & dev_warn" branch. Maybe this change speed up the code a bit.

I suggest to improve also this commit message.

* Please reduce uncertainty.

* An imperative wording is probably preferred, isn't it?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D152036d1379ffd6985262743=
dcf6b0f9c75f83a4#n151

* Will it be more appropriate to refer to the transformation =E2=80=9CRedu=
ce the lock scope=E2=80=9D?

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the change desc=
ription?

Regards,
Markus
