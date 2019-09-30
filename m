Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF9C2451
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfI3PcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 11:32:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38824 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfI3PcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 11:32:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id x10so7598049pgi.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Sep 2019 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=b9OIKjSpfkGrTr/Y+X6VF1Witd9jN67vbQVGdxPPoBs=;
        b=DspFEq75s07cCzNf7CqP6PTbMlsS4I1/Y5EMMidfiBKMKPEOVkzHyfB86z4hXh5CYv
         Sb13RT2+eu/w7qNYHeavj7j9zZjYB4aDH3fEkvuCes729VTlJBHJ1UjaI8ztmdgmBRm0
         Logvd/uy6w9zJVAxYWfvbsQjCx/vF255+NMRMeA64Lsl98tV2UihbhqADqSgR+A+Wlcu
         UlMetQe7vajfPbtYGmgC1Hf8KI1Lflf6YkdwaEoUoj9yi9278RdZoZOXz55gMP3h+h2i
         44VWq9QDXxgm6JQhORBO8WzpXqktlFGS7/AfmaeTTTtbPS+8pVDytfqNGGiZ6sYMaHNg
         3CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=b9OIKjSpfkGrTr/Y+X6VF1Witd9jN67vbQVGdxPPoBs=;
        b=DdsL4ldzO0nf6CZDSd++9WUpSqAY729AZGUf9VxFB1G8Olt/DsiNstC5bGwv0U5s64
         oijp89mi73vw2o6kxP+M3np896B3FHdNtBZ/QHDDF0sPj1GhW4GgBRXu3mheA27MZVAh
         2aLo0wDsESNyg7y75NzQOKWKmzJH6g4ahi5TQNgz+TBPdFQnhmGQF7vwuX8yq4xgNxK/
         VoT9atqce4FiGT+AglVblE58jdCE877OjLMwwfryoFceY0c+lmaWx9XMb47FnxHwszn0
         CnqCZJMR+RhsC1tqQxTMCcRLSfMllyzqyAP0aTGkhSMbF5s/pWv8UQN/t0uVcLmnKkOG
         4AgQ==
X-Gm-Message-State: APjAAAWRxNToulo32YTFU+fMzWHcveQftzTuDsqCZEDcIUoR7vlewgd1
        TdFffG9XGTmDeYdrRbchn7ZmnQ==
X-Google-Smtp-Source: APXvYqydQjTboQcTPVReW9T7Hi/m3KQq6ErGddNRlsfOxd4kT5ADyRwF+TwSTZBJlbg8hvOPivEyBA==
X-Received: by 2002:a63:cb07:: with SMTP id p7mr24892312pgg.232.1569857522901;
        Mon, 30 Sep 2019 08:32:02 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y7sm11869079pfn.142.2019.09.30.08.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 08:32:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: amlogic: ee-pwrc: ensure driver state maches HW state
In-Reply-To: <1jd0fi19dn.fsf@starbuckisacylon.baylibre.com>
References: <20190925213528.21515-1-khilman@kernel.org> <20190925213528.21515-3-khilman@kernel.org> <8936e777-8996-5c7b-ea9d-8e17c8d6c4b1@baylibre.com> <7hwodulvu6.fsf@baylibre.com> <21eafa69-fe26-2df1-d187-cddfe5b37951@baylibre.com> <1jd0fi19dn.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 30 Sep 2019 08:32:01 -0700
Message-ID: <7hv9t9g5qm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Fri 27 Sep 2019 at 08:37, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
>> On 26/09/2019 21:08, Kevin Hilman wrote:
>>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>> 
>>>> On 25/09/2019 23:35, Kevin Hilman wrote:
>>>>> From: Kevin Hilman <khilman@baylibre.com>
>>>>>
>>>>> During init, ensure that the driver on/off state as well as clock and
>>>>> reset state matches the hardware state.  Do this by always calling the
>>>>> drivers 'on' function, and then callling the 'off' function if the
>>>>> HW state was initially detected as off.
>>> 
>>> [...]
>>> 
>>>> I don't see what you are trying to solve except simplifying the code.
>>> 
>>> Simplifying the code is a worthwhile goal on its own, but that's not the
>>> only thing I'm tring to accomplish.
>>
>> I still find it ugly to power_on a domain to power it off right afterwards.
>> The issue is with the CCF enable handling which is not in sync with the
>> HW, if you boot with an already enabled clock, it won't be marked enabled
>> in CCF, and it's clearly bad when you want to have a fine-tuned gate state
>> handling.
>>
>
> CCF should disable unused clock so, in theory, you should not have to
> call enable() then disable() to get things in sync.

But CCF won't disabled unused clocks until late(ish) in the boot
process, which is also when the unused PM domains will be disabled, so I
think there's still a potential for race between the late "disable
unused" features of clocks and pm-domains.

Kevin
