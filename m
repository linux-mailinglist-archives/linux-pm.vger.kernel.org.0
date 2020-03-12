Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B45183A9C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 21:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCLU0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 16:26:55 -0400
Received: from foss.arm.com ([217.140.110.172]:41204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLU0z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Mar 2020 16:26:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C496731B;
        Thu, 12 Mar 2020 13:26:54 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 517403F67D;
        Thu, 12 Mar 2020 13:26:52 -0700 (PDT)
Subject: Re: [PATCH v2] thermal: devfreq_cooling: Use PM QoS to set frequency
 limits
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
References: <CGME20200116231233epcas1p363ab7e3ad2966d0ae7bac11e33aa6b83@epcas1p3.samsung.com>
 <20200116151219.v2.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <d73e67eb-4f2d-dc4b-c718-929a964d3640@samsung.com>
 <20200312003519.GD144492@google.com>
 <f09ad5b3-c997-187a-d637-cc7cdcb282f9@arm.com>
 <20200312175701.GE144492@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <40e0af31-d6dd-d51e-ce48-46dfe85e67da@arm.com>
Date:   Thu, 12 Mar 2020 20:26:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200312175701.GE144492@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 3/12/20 5:57 PM, Matthias Kaehlcke wrote:
> Hi Lukasz,
> 
> thanks for the review!
> 
> I'll rebase and send v3. Hopefully it doesn't cause too much extra
> work for your changes.

No worries, your change is really needed. It will simply the code
that I am working on (can be found here [1]). I don't have
deal with the race with devfreq governor now.

Thank you for working on it.

Lukasz

[1] https://lkml.org/lkml/2020/3/9/475
