Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8B0232EB
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 13:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfETLnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 07:43:50 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfETLnu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 07:43:50 -0400
Received: from [192.168.178.167] ([109.104.33.162]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYvse-1h6m602i7U-00UuCV; Mon, 20 May 2019 13:43:32 +0200
Subject: Re: [RFC v2 2/5] clk: bcm2835: set pllb_arm divisor as readonly
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     linux-arm-kernel@lists.infradead.org, ptesarik@suse.com,
        sboyd@kernel.org, viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
 <20190520104708.11980-3-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <83dff5b5-e02b-4e9c-7ac6-4274e9b75d92@i2se.com>
Date:   Mon, 20 May 2019 13:43:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520104708.11980-3-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:b3aMKpG0czxEiB5cnBOw5GHKfiT31mDT0tMmgPMv9aHOWozAfZe
 w3orjCSXH7Vxz08eXThCBisERBmEVRTyVFS+HZxSvZ+K9BL+LOkWeDmZn2Zfrs/XYDeJmPx
 Yvcwa9n048RfjWpBckqkvlgc+M/lvExJ8XNkp25PpmNuh/3JRTPRxLf5llIPu9uAVeIT/kK
 JbsESJMHDGcKGLkMq0YGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bhd4d+/twfY=:SefFMlw6XmltgfzFN+tJJp
 SrytOrejJlcaQ2HQWpCgL93NV8hM4sDhcbf3pd9e6goISvejw8J0tKgJfOm64QHZycq5SlkXu
 m+sE81NkFY14U91gauObbqFP0RfmQYwOpdBrYdn26+1ejN3sl2sHv86e60f0Zg4Sgh9ENuP27
 /Cf826VfCMaNKqcLfI1fSFurQU/2DhvUeFnqCrkKyZzIwXXVkl0LKS9cTpdfmivWd2BRq2NXQ
 PWvImTZO+YD2NPRQHv+Z0T0iBSiogMJS0N1T/UVSm13huaPDiAHoXv/y694z5Mv84/VCpf6z3
 dMgf5TetPdazToAQMSKIECno20iz0J1ZUPC8FD9zZnOddjwt5GQK5GDu2dXVhgcCVEG+WYm8r
 jDS1oFjBEA1h1DWlncjK1oTl3BOJqGBx/xMyQSHcXxAnG6l8IDujpat8LFw3ULyTMOQO9tb4/
 uWnQeztbMcJ0Vdn2DZaQ7ur0nuJdaA0kZOGjnlot/vYljCc9vvtny3mB/uq+buWZ+un297KRA
 2HIapl3pTEsaUS1hdmzHv76ksNJPoxTu/4u7yR+uBM7VG/WpKdVJiEHYD1LOpcnUU42q77m8H
 kxtJDAXkyExUjsWwhPrZu/sr7YuMXSe5yanzW530OaMLcHtUyF3BRsT5p+ZfeOzEoQb7pDhzT
 QRYuaRG/g5AvtOjwfJLgt+FD+vX+XA9dO6jWzzL3c6HaQc6deUq/UiBXuFsni2CXJ5hrTAKNT
 wA/tYpq0fomv70TP4BkyufZMDUVLP/zEM2fDiqZ3FO49+Iya3ayJfEF0/Ls=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
> This divisor is controlled by the firmware, we don't want the clock
> subsystem to update it inadvertently.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
