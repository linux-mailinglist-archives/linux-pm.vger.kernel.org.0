Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C911365C17
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbhDTPZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 11:25:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:33059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232174AbhDTPZG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 11:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618932256;
        bh=hVQLEwhfpRjsVnuKwpAXjLX06PhCisojyl1TbE7YIJI=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=B5daLXcRBUfZ4q5jCyjFrCq69sgTrDWI9eZ/QcvkNB8tfi3BhMXqJ3paedV7Jwh+f
         YhBQwMCqF1dGYXQ3reR0TFUaSXlP5bk+GmGHq7Nr7BcqRLnECs+r0FQ4+quNkXsyz9
         Les1iNUD2zGOHcwj6GzMMr2CT8Kv6DKwru6XSlDs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([80.245.77.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1loLt30fk1-00tUuy; Tue, 20
 Apr 2021 17:24:16 +0200
Date:   Tue, 20 Apr 2021 17:24:11 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <b38c3539-c864-67b3-95e8-9b652cf6fcbf@linaro.org>
References: <20210320080646.49615-1-linux@fw-web.de> <f4329b1a-02e0-aad5-55bd-82d30a38fc55@linaro.org> <trinity-4a3f024e-c01d-44e4-a884-530135853d33-1618930770250@3c-app-gmx-bs72> <b38c3539-c864-67b3-95e8-9b652cf6fcbf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Aw: Re: [PATCH] thermal: mediatek: add sensors-support
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Frank Wunderlich <linux@fw-web.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <846366E9-5029-4C6A-B2EC-F70D901DC379@public-files.de>
X-Provags-ID: V03:K1:qFuuvC3OlH8wiI0uAUwIouverCIxk4Zh6maix0KNR/wBu6KQ9ev
 PmnQbGVqCpI86dfVRGhDB+Oz0h7VKfnVUy+XYZTUPvCMo796TC4z7GCS1hakQjTzMKMt5pi
 3SmiuV2id/1hB/7OHJYi/pxoZO2Ipq2MEzqHQJ33vba3PHbCjEJg5D6TelBQrppipOFkl3T
 Tyg7Ru+LN5Zy1sdyOV4HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oz4RHvbnNho=:tXJISebCrSiN4iZZwwTbe2
 ydjY+XWqFzS9xGX+qZyIyH2yxzBVDdkd71rw6Z6jjRmVdSH1Y5DZ2OJxoynvazDJ46rU8NowF
 V8dYIMZ/HnqhOmK135T1zTsZcTZB1OgUUsipLv4flIzjjdNuUXcvV7qOHk0kZiEKoDIOPNqmT
 10VUn68/euizm9nYXaNnXTSj1Tzt817bhPOAwvw5xp9JYdaW43lsxxawEcrBe9iKt7K5u7bC/
 Xo75MIal9lpxVhM9AmFBClTPqplyZNJCFkgVoT3ig6KNOVkM9GDIO0VYJ7LnStnH/VgVoUqj9
 2/G7KYzoPChRwG/Me1Dgr2L6uEujA0dRVfVtvsk2ePoI777D7uIvr1W2aFP3NU813EmsJc2Ua
 rheSMcgiz721yU9mugWMiMWvsaate0t28+Jh1lUzar1xj+Uo8eaxUIJP+lB6Axan9xacXB1J+
 Kvy5YWVcdhoLU8uJH5b7mOLuX4AwiOQBbhvWRtQJhqkpCqrN+8jlXe6GnFHybIpnYS3bc1txC
 vWk3tb1WeB8f7aVzZGFkDRXEiRV7Lfqmjs3y8cM5p5eqUu7h1ra8BQuFl8JIxXWnVETF4N/K0
 a9U50yzbmtcoZRgZfJx845X6coKz8BmFNHQj4JlkH3fyE4CCp492Tzc/vMfRz1ChjN6oqiY/u
 6PvPcxYdzorbs3SdzK0DzzoQ95K7/3PEYybeMsChpYjHuHCoVRlVNsWT+Wm8G6um2AnQYfhB/
 yw8q6e6KIFITo8GiBiTHdSMF9kLlVHNvTyWEOfD2Qsk4Qi3lIKtcAYRArrkfcaOmWUOz75kVv
 xpLw4/eQt+EuaHilryyH2FRMnsN0ipR2oBxNJidjUai5Vf7Aeo0XZEgAwLfhyinZapMJFV8gK
 cPCL3818Vb2DbD8YY21iTU8sQOX8SB1ACRDx0/orxGBKBqZpqWeOqVdgCO4EY8I3lOz/oFiYe
 yMTBvAf05WszTO4kiq1bT8okWs5YPAiedVamWymFUBQP2XXnokvdfOriibyVlN6NXatc0Kb5Q
 9hLO6DGGxKV4xrbVEIX9roR6gZXeSjo0g0vSbMgjFgXEMh6YAVoZQNCvJqlTNSXOmmZJzGUtg
 hv442VSmo1BpWkWoOT7dA9AojBdSd0p/SdMDckfa6oeDa8nmm6Ms5tQMfVNtM1CgrHnz7zpmU
 ++D3eo1WB4Lg/iZfhO5IvEdx93frqrK9h9aWIg4Sz+FhEl/VkIPDc3ejrnlB7V8qH0Mixu1gW
 RamW1HMnxVC5WByZD
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 20=2E April 2021 17:18:32 MESZ schrieb Daniel Lezcano <daniel=2Elezcano@=
linaro=2Eorg>:
>
>Hi Frank,

>The no_hwmon usage is a bit fuzzy in the thermal core code=2E

Maybe add depency in Kconfig? Else we can get undefined symbols on linking

regards Frank
