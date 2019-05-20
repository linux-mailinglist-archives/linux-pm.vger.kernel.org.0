Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCD232D5
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 13:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfETLmf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 07:42:35 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbfETLmf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2019 07:42:35 -0400
Received: from [192.168.178.167] ([109.104.33.162]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MbC5g-1gvYmx0jaS-00bXPs; Mon, 20 May 2019 13:42:11 +0200
Subject: Re: [RFC v2 1/5] clk: bcm2835: set CLK_GET_RATE_NOCACHE on CPU clocks
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
 <20190520104708.11980-2-nsaenzjulienne@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <7d9cfcb9-1585-bba5-62ab-bddc0b57615a@i2se.com>
Date:   Mon, 20 May 2019 13:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520104708.11980-2-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:+Lmwa+SIqFPVVnun6thuV1j2JcxQcER6nNgcoUgpmmiScCLPyhN
 ysfqKERDrLC62ytnS5aHhg/wF1Q13gNwfpkxcDnpmzIQ8W+tpru5b6UfI6b/EIjyD/Zvper
 D/+7gkRjBiPgdown9eFrYDhkCbF1LbhSpWK07Gv2EJaPu2S4DGEpQ4LHOSjRCx4vvWR348U
 3D50Wf8sFfkfbyjse6vTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fzLvTIN16dM=:UdndameqEvX/cJj80HKwWz
 AIUovWKMCuXKm1+/35kvJ+CepmfzWCxLy1wiHyj8YZN3Tz1X2OnesnnzeTdsl//yIvOPYOXsJ
 RzzfSk/Kg09g4gPo35E4/EUtZ89A3vY6n1U66hNvAk5PzCrqcSRuKk5prmJCST5kuEN+9qfKF
 sKtD0jNf3xTJxZNrIPtO4ZzDd/mAELnLhefuDU2XnLioDMCXIxVlDTPx0ObEajNlc1JuXzjgA
 0cVpfpHev9ZIfFKJz3ZyQIBceHBJnkXCiVZqGIlXV1MBSUOCqjldoYfA1GzOAuGumL/DHNNI9
 Ktun9lFkP3KOyTATUygiKvcrQfy8ZXAdjc/yizweUiCGrQUUvtMLwLb+sB/pu7vn1llrWlOtw
 j7kK1Gqve0vyX/qc4PVdp6jY6rDZB61K4J86zEVheF7l73RM+h7nbW2udf4kicChuCjZvJAkI
 PRcls4jT80A6kSzdzYQwS/QooJqrui9valGIgMQ9BtzPSuJnkEuunihTNjgmZMpCTPsOlmkrH
 wpBcVYy7u3FqxHm4C9NWkUGU/JuJl+G+erIljdn4YT8J0NZnARAXZciVizP9mfLd9qToA02Eu
 K01zXei+CRAiIzwk0aVdQfPcay9EQpAt6FAra8Ukf3ZjfgvOpY0GXJKM/wYfQJqBc8YwY5nt1
 99Fy9QlvYg3Q+wnmA1B12uS64KahnU5QC9nn6ce3vBSJevMXITT8ZZJGOAyBbsW3ilIoHqCYw
 Oi1hIa36Ksg9rQRjIYO9ZsDOLPQBZuFv5DdbOQLqx1iK3MmeFUtYqWUZ8Cw=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.05.19 12:47, Nicolas Saenz Julienne wrote:
> Raspberry Pi's firmware is responsible for updating the cpu clocks and
> pll. This makes sure we get the right rates anytime.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
