Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F55010EB77
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 15:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfLBOVC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 09:21:02 -0500
Received: from mail.sembritzki.me ([5.45.101.249]:48500 "EHLO
        mail.sembritzki.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLBOVC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2019 09:21:02 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 09:21:00 EST
Received: from [192.168.1.32] (p5DED73BA.dip0.t-ipconnect.de [93.237.115.186])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.sembritzki.me (Postfix) with ESMTPSA id 67DF7A601E;
        Mon,  2 Dec 2019 15:12:01 +0100 (CET)
Subject: Re: [RFC PATCH] PM: Add a switch for disabling/enabling sync() before
 suspend
To:     Jonas Meurer <jonas@freesources.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>
References: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
 <2847488.TR0R5COpHM@kreacher>
 <063b2b9e-19f1-e67a-1d54-b1a813364bb8@freesources.org>
 <3858a5b3-7e62-977e-0292-964c4dcfef5a@freesources.org>
 <CAJZ5v0gNAONVcfvrUu4DBPBo=YzWW2NK-3774_Hv__p2JWmPgA@mail.gmail.com>
 <9b8ac136-bd5b-aa4b-fa7f-109e4a61dd28@freesources.org>
 <d9ac5225-51fb-8207-5661-64089ad98a4e@freesources.org>
 <355b0fb4-47da-3ab8-bc65-5191cd8882d6@freesources.org>
From:   Yannik Sembritzki <yannik@sembritzki.me>
Autocrypt: addr=yannik@sembritzki.me; prefer-encrypt=mutual; keydata=
 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
 XPXxm2pP
Message-ID: <86d9ea4b-5f51-4c39-6b6e-6c19b5559da1@sembritzki.me>
Date:   Mon, 2 Dec 2019 15:12:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <355b0fb4-47da-3ab8-bc65-5191cd8882d6@freesources.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Jonas,

thanks for the patch, it looks promising to me.

I'd suggest you send it to lkml for additional feedback.

Best regards
Yannik

On 12.11.19 12:00, Jonas Meurer wrote:
> Hi Rafael,
>
> Jonas Meurer:
>> Jonas Meurer:
>>> Rafael J. Wysocki:
>>>> On Mon, Oct 21, 2019 at 12:47 PM Jonas Meurer <jonas@freesources.org> wrote:
>>>>> Hi Rafael and linux-pm maintainers,
>>>>>
>>>>> sorry for the noise, but again: is there a chance to get a brief review
>>>>> of my patchset?
>>>>>
>>>>> Probably it was a bad idea to rename the build-time flag, right? Should
>>>>> I revert that part of the patch?
>>>> Sorry for the delay, I'll get to your patches in the next couple of days.
>>> No worries. Thanks a lot for looking into it. It's no problem at all for
>>> me/us if it takes a few more days. Just wanted to make sure that it
>>> doesn't get lost.
>>>
>>> If you find a minute to give a quick comment on whether I should revert
>>> the renaming of build-time flag CONFIG_SUSPEND_SKIP_SYNC to
>>> CONFIG_SKIP_SYNC_ON_SUSPEND, then I could do that in advance to your
>>> thorough review.
>> I went ahead now and reverted the renaming of build-time flag
>> CONFIG_SUSPEND_SKIP_SYNC[1]. There's no reason to do so and it breaks
>> backwards-compability.
>>
>> Rafael, could you take a look at the patches anytime soon? I'd like to
>> propose them for inclusion into the Linux Kernel within the next weeks.
>> Again the question: would you sign them (if you consider them sensible)?
>> It's my first Linux Kernel contribution, so I'm unsure about the
>> process. My understanding is that a subsystem maintainer should approve
>> the patches first before they can be proposed for upstream integration,
>> right?
> Just another friendly reminder: do you think you find time to look into
> my patchset anytime soon? Or shall I re-send them with lkml in the loop
> as they are?
>
> Kind regards
>  jonas
>

