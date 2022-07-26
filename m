Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835675815A0
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jul 2022 16:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGZOpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jul 2022 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiGZOpc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2022 10:45:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8962191
        for <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658846729;
        bh=nHm0B2hUeEzzXJWJVQV1yN7/IgMXWE9D0NtLLQLkSqo=;
        h=X-UI-Sender-Class:Date:From:Subject:To;
        b=KbFl3RUCRW6KQHdrBn05xkyEp1kSgtVoY9UlaO+GnWwAO8QpblcexqIqt+E3m6gLR
         BH/7sOpmcEx8R2Y6mtecmsQO50zE35bqq0apO9FC4KX1CITIBUnySGBiWpnV+YKkCW
         KwAMSa4CN23Bc4ErC5bUZvwlCBAoq0rsV3YCGzls=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.100.20] ([46.142.32.206]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1oIljj40Hv-00FCMa for
 <linux-pm@vger.kernel.org>; Tue, 26 Jul 2022 16:45:29 +0200
Message-ID: <d94ca3ec-963c-a68c-89cc-f5e10f16a40f@gmx.de>
Date:   Tue, 26 Jul 2022 16:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Ronald Warsow <rwarsow@gmx.de>
Subject: RE: idle CPU freq with kernel 5.19-rcX
To:     linux-pm@vger.kernel.org
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G/a4WI/nXfpEhQbO9e4nsmRTH2mxWoEm30XpanuyCkZu6qJdAcx
 +uT21C6CrY5HMKFySurIxuKDOXRL0pLCkHjErOzSEI3ImJ6ZhdYIMiFdmFTT5SRkjRA94Bv
 dFcgqQ+P5dI2xcEAytmTxQOksLdLM2c9/0SnV6fOpisRiVjPKhpue/Yf3B30Us4tTh/PkIL
 6p03AjAL1u5rg+Gf6pvxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6PCs7tOOpcE=:Qk2nsQH+7Q3Fb/9O7lNVzW
 /h7CYrHiE1PSM/iuehzDQA2msNaFzQAFzeJm4Jl/qO2tDRqucs/ee4fuKbdPA0VpdlT/1yCEz
 xAyWeZRQA7TvWHkupOTp2h5kJufJZwxd2J4aYrivyrMpFfncO+6X5hNvkYvDhT159uBqdtsM8
 srhcr2iPz9aFs4JnW6c7ekZeMoFdwsqMkGeeccKDYrtZg7Ym3q/J4Dxuxqw6AuoKH38qL0F8s
 Hyeqsv9huSvFex40rQwIavvHeZbww9OF3JXy+a2Ct8QSrfL6ae6FPybQGGoo2jVZpFdauWYfw
 WKgHJnv3r70zPUyJkP3w9uyjZe+p0v6PrNPIKWhrA0J04TfH+KmrG+vLbV+2eInvuCAJTc6ps
 JvCcWH1/VuGiyBfGOFffbrEHph1hvi//n1gmY7h6WiWYgE8MI/dzZLZ1NmAk+w+kqee409oea
 F4BMQiyUumtVOiySCpks0XeiUSjxfQv3eCsq8rzR54YC8EQCnqg3qJttG8ZNcextiktxe0pKK
 vLxBRRrCR36oe8OhqNTRwT0jx3C80j0rSPszj2Gr41HWXYpfotW8g9+UCDv3CtJS5s4qmrUWG
 PJ8uIF2RgEx5Kl0qXllgxGxZiNFkhgiywIYSb2fAwF1j49NHZR4i4ogZenzbFAy0vGPD2Ge9e
 lGyZpIjM4jtg7nX3g5Fo7n/CvBFrNtseso13jCkwzIa6ZFrAiWFZ1JctJE2U3llWhAup0xT8r
 m3axl5nXmuZHdChrQTvU9gQ9ry6deBAXKyT69XOt5o0WZv1agUt1gPTE1Mx/XY6zD1t8mL5/7
 CEBAFE5I5oIm+5OuuOG0t2Uia/WpY2CRpbUyVN3X72+v+BX0Psw/FO1DF0tI8X4vg8pDpwS2x
 5x5hVCrCkLmD9m4I+BNAbacaUBlxe92rPZg1BPRqyTZ9sAfyDUO51UjsoG5Haw2Ppwh9PppRC
 yxDEDTEvVyXi/R/Qg1ng7zqCo+USeSU5drLI2Oc/mp54LqVuk0nwc6io1WW5jBJuQHpVrmC0M
 YBf8TW4s/uInP46oyVXSEepWYHjRRBC6VxUVav0ZPx7VVqFZAJrdjqoa6aOG4JYR+qGeFYBYW
 1/Ev9doNQ0GFqOF9pcdjwSLd3K2/6j6HpQj
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

hallo Doug

...

thanks for clarification

Ronald

