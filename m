Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD1233AA
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 14:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbfETMT2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 08:19:28 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50843 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387820AbfETMT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 08:19:27 -0400
Received: from [192.168.178.167] ([109.104.33.162]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqsL3-1gpFl41RHl-00mrvz; Mon, 20 May 2019 14:19:07 +0200
Subject: Re: [RFC v2 4/5] dts: bcm2837: add per-cpu clock devices
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
 <20190520104708.11980-5-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <af50c1e9-5f52-e06b-8d0b-c9f72fba1324@i2se.com>
Date:   Mon, 20 May 2019 14:19:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520104708.11980-5-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:bNR85Xr5Ix+/N8OQzcAK+XY4eUmxwoteVwKocla9a9I7HzkvLcM
 /uiEboQgspShU1W4QTj7siUuy0oqooMehPTXT7eDhfGc4LVkxMDK8Ve1bX0/mEX0dvWe9cY
 ZBTCwKlQSXk3lfET5gAOnFazcF6lfCik5yk+iEsANhQDdrD/6+D6LHXfcPesRRjYroYeLA5
 r4Oi7dFGZg0MqE9xQ+Aeg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6J1Fp4MKs28=:EUhQ8mvrBMpbz/M+ADxWx3
 r/nxWy6+BZ9mkIz0Jn843As9r2wZB17pO/yhpXhG8Wcd6DfI3VO8BU+joDy00A6lI4nTkkvpb
 juD4rVnuBJvH8GH0iARDEgvNWwaj2NnvHhllrxCQsaD9F4LkHDbPlcDtCh9tBCLHHvlg2+CMi
 zo7li5BCz7kfnu6fh4mLkgG7/LlDT5OsIsePWv9qZvbt5oOkfJuRENFOVVFhml8ZKAEf576aV
 Uh4KmJ9u+g5H2zk1KqHGPfMt5Qgzsioxxjoa/kjddfijnYCtvBznCcemvh/OiGN4uJVZBKjbN
 dTv81y2YGx47evOYezaPrDgGCmDPICIaregOF4cCz40R1xoKKhF77HqsSDQKXs/WG6CBD+Eo5
 a2k2IKVKIEpfBK6NCkM4i2pUOU6aLtDYe0L4ocYMu+Y82Qg3GvFYvUYSmiQl3DRZ+TMCJhrNv
 mdvkgm7848M7em8ysrSzfVwYssutfMW11SojWGyXlgqEN6HeOXSKwbhzz3RnhhbkpKs5tF0Y0
 XJrrxF4+a5Ym/LrItbxkz53pjRwiOr+QirImQtfP+mA0gHI1DK5IKkMloFOZJWmjX5oavoAdN
 TRnAretttyb/aSU1GjCjDfUPBYsFoDCfFHHL0soDOkZL0Pq3zjA2QADigHSIquHz60uPPAYWv
 xmXaDQBQsoL1BguVHzwiFVpiEY1xf904cAZMJEEIRKeWCxWQxM81yyASMd1drUXqPdg096jtA
 4wM1Bfs/IbW91rTOPRpHtsyA76i1t7j850Kw3ZzTMdDk643oku66LbG8L0hLRUl59drWFpCcU
 HtB52UfDRRY9i4xIkEgI15kY27xVxBk1+4VSC1i7DK3ybJD3zSb+QTSnswW/27Q34u0eNWZ23
 vzkE8vSFO7liN76e2kHw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
> The four CPUs share a same clock source called pllb_arm. The clock can
> be scaled through the raspberrypi firmware interface.
do you see a problem with applying this also to bcm2835.dtsi and
bcm2836.dtsi?
