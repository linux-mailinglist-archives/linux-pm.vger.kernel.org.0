Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70FBB139A15
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 20:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMTVP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Mon, 13 Jan 2020 14:21:15 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:53513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTVO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 14:21:14 -0500
Received: from [192.168.1.176] ([37.4.249.154]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Myb8P-1jaHOY1U5t-00z0Cc; Mon, 13 Jan 2020 20:20:59 +0100
Subject: Re: [PATCH V5 0/4] ARM: Enable thermal support for Raspberry Pi 4
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
 <250b15ef-636f-d964-3eba-0067c07e5a9c@linaro.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <4a2b7974-db0f-bd0d-21f5-ccdc0ad2bc30@i2se.com>
Date:   Mon, 13 Jan 2020 20:20:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <250b15ef-636f-d964-3eba-0067c07e5a9c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:mFQrqbK9TfoYCgrdE6SQRQZMmKAXp5p6YUdmRjVHubNgVfsQhex
 7KkCmDzwibuUN0GbVPNaO37hw+//GFEVodYsbZTOb6q1BOnZJ6eDGJCnadDYmI8BEJbc0Ci
 Yu8vl3qh8sBNTUjRRx3Vm48xTd4K5RriaF2fwu6+cJ6xU5qmahjV+F0Su92H12SopH6OYVS
 Q+Vd2G3IsW8N8uZoWypqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZUeCEUdzKU=:ULAgnOXzCCBftYuwLx1CmJ
 dXU7WxuiIdWpAgkgcCiiAyCwVWzpPbPbLDMvA9LpBPNuDjPoCIxVXL8P0tKAJzH0dT6XvP9KA
 GGM/b4GjpGGzXfpZG7SoACSBprrUQOJIF+K1jkK+ifQt55B6fQCcip4/cMhZvXngNSZkjv+SS
 pSaUW8HvSzAETVIIqVdBwdgteFJRM6OURCor0IYyxdHFrPCp2P8NoYrzpciunwR5pln1ReiGP
 bPnpBzqEeDYdJElb3nZ1xZjIS2Uaqo6mxk+bo386ADw2/Ew9CMRqCIFcJtosedhZJyO4U0hdo
 DCfC1pP/3FO0Q3elgf/xNUBDWuihKRtTKBW+UMXno0vYu7LQVdcS03LBBwCyIvCmEuAMHzw1k
 WVNIkt/sj4wSLyJMTM4Y8I0J/ObJVKZqHLz77FrSSRAbq0i1jDr4UnGy3THzD+EUq10BAxHbb
 Kxm7/00vjXwWe/OsVWtUW0upXItjr9+U1STosdOVO8RQR0Tnb5h326SlcFOeWqiWmJvVjTSjk
 AznvSzu1fpAYyLSBZANWtEQpaUoSN5Eor8f3pOn/HrISfUWguti1NxvIlg5+IXWMJ55vzPYlO
 TgcesdfM9+768V9uzq5KF6PhWh8QmSQ8njTakBTuvEbZ1CoVQ/GwEG4PLn/cUPKrTNko74YA2
 n7Roy+BRM/q8r9M3CxiXUhvc47vNAXX9blc86P7ebHOpaJ9iCPcjyj0R8E8ibN/YT+SE/sLBj
 ScyQkHrxRkW1R6RMbw85VQQl3p2Zih7Nfmxy6yQh6TyywmenhCGY1wkiozvGDSMmEEgJrdfW7
 jlZNoZZ2Tc8BVrNg+vsuaBKcADvSQsD6i788xnSoXwF0wKZB9fqhGuFzujzkbwAjsmTFZNxtz
 5qy7YKU6BFbECqDJxequIz+16BQyyBIndXmB8x1Aw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Am 13.01.20 um 20:10 schrieb Daniel Lezcano:
> Hi Stefan,
>
> how do you want the series merged?

i'm not BCM2835 maintainer anymore, so the final decision is up to
Nicolas or Florian.

But if i can make a wish, it would be nice to take as much as possible
via the thermal tree, because Nicolas already sent the pull requests for
5.6.

Thanks
Stefan

