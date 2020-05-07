Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18D1C8FA2
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgEGOdg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 10:33:36 -0400
Received: from mout.web.de ([212.227.15.4]:59407 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbgEGO3c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 May 2020 10:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588861737;
        bh=hRLzFjqMPtDpW6jaUTHnv92MsHiOAEiVe/fxxJwFA8s=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Un1aTWvNTz2LMng+po0iOeNdhnGWUDw4hkqdATOVPTKPohdrujTpIFZcDNbprN1cS
         wE0vjHnmEFinpaNGFi5Np62qt/283aPMYM6KVxL2yRzFd2rUiuKJZYvPtwsCnUjm3S
         WNFdGtcJ9iXAMeWTDTa13fU6UmQ8O3BYnbdEhUIg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.29.220]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUF50-1jg9Rz1d7S-00QzCH; Thu, 07
 May 2020 16:28:57 +0200
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Fabio Estevam <festevam@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] PM / devfreq: imx: Fix inconsistent IS_ERR and PTR_ERR in
 imx_bus_init_icc()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <043e36c9-51b9-3662-e972-2cea7c8ec431@web.de>
Date:   Thu, 7 May 2020 16:28:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:i7nCXOT+UA+luCj40rwMAEapeZ3woRlIWlKkvUo2n/HC5sXuMCl
 K7Y/mFDhf4YeWHZaej0QqaQuroTeTnJDIk1hcE03mGRLoml++9IPsulleWwA3dVQ7KuCRJv
 QpextPoVh0pe32vD3Xak+l9VVdDk9YOcTbZ7KxpzjhjccNsRmxqF9TkCVCPfgJPbGpI7MPH
 4RpszXZ/eDnorzDTcqtUw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nv7VkjAW57Y=:3DiGCS8xRrTL3bmWwir412
 LxGub3mkh1/mXGvbU7+a1W9D/j9E/6BR98SxCk2MqZ5aVj1EfOwXMfiSOao5/V5sYt2GKtnuL
 CNI/SC0yd5N+81XHMBEo1sYjdH+yQLLaGYP0ZYYK0jW7FHA0qetQvmcJS7SMfM0LftKiFkxZr
 361qbWWtRRahXc7np/7kH2HOB0ndegxd09LBfLQS9buDhMoFsXCHIaqS3/y+RFp2yCCeIy76B
 h9Sf5OuBGx3cTsP5kIGEuu2QrmQxlTV1QeTIjErH74AAGCud9WG/IAkIJ6L1VJsYmZEEtftz+
 LaGP6zEm7l/8OtROQ6KDZna1URxWMXsptbZk50Os6LjrcQDUnYrv5O7qVu/hZLYOV57DPJEV8
 LQTa5LFKBERuP/5iwOg5UMOwTpVMlm0/pry4bk+zEt0cdRoNaGkb4ZqDqFWqsDZalr1+LPbCo
 d3nK2dAzLOL9AfjzJBRJRtvNtFU0cWPJyM0xXq8rixJtGX3N1975KZ0MOOnz5sHqsnWpRuJVM
 FMyix41dgK3x/OFHyuIFZ3FQMwqRLKYp8uYTttd7A+Hh2RWfbrhPORZLdQoWTk0nnwimTBXrY
 JEVovygNtMeGLpteXUnhPMSlSgZph2JAb1qKNTS19GzRqkR+8ZOl3mGy19LSmIQlk0ogXZ08V
 9uKM9ehZ4wq/QKAY9qRvqTuo2Eku/yQPv5zYA92Kb1Qc9SBv4tVfxZbDuYf+a+s+dhbcG0O0A
 /ChhFNpsoAZoIds4inlyTUcSPXq1gF3n/04VpPfkG79yanHamiuA1P0VyqectXRtazGBf1Cwb
 VAFVwmN2Igg+H4gOlnbO84ZTwXiiAbxvWNx0qZ5mDB4v489R3zIatm2RBWX53V1weKEp5m+V1
 08NqwPDfa/w3WSkzBMGhwcqGAqMXzbAGEEQONnLn9AtohsscWfyC16vs7K0tS9GQL8iY88ZZR
 rI+rk92NOQzpJEM8rrI51dvbmXr1IPLOD77i5jnP8Oe/d97vCeESmmpJDFcZ9ijA6C1FkygSC
 CFvWmgTuhlwFyT6LgiFiTohQR5Mpwh6xAiTQ6uCqu7ZKSSIhRdRAoF7nAGeVx3roC+sODzjak
 hWSrvovLLXyq/8F7u6v+/oUIjmNSG/V5ItXEF1M3J4O74r6es3DEpP2TjLb8bW6BYtt/lVxQO
 8dsx+x5lvDCdFJ3pZBZDZVwNvmQ30TTLsd9d+4IrS7H04o7hF1tsUpIeDUl54dlz/+YyrpdYa
 NezHmj97I5J1xvGUv
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Fix inconsistent IS_ERR and PTR_ERR in imx_bus_init_icc().
>
> The proper pointer to be passed as argument to PTR_ERR() is
> priv->icc_pdev.
>
> This bug was detected with the help of Coccinelle.

Can the following information be also helpful?

Generated by: scripts/coccinelle/tests/odd_ptr_err.cocci

Regards,
Markus
