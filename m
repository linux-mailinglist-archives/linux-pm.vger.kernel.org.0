Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059EA134068
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAHLZ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 06:25:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34953 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgAHLZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 06:25:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1015421plt.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2020 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jDjtJ0LH2mOG9+BZqbx8yqqoSjYxW1SBZl9GtzI988=;
        b=CtjHRbGpYB3RTWUy42hyridIUPO9xTDmfbMefaeG71PHp+Sf/G1DKQINkrtN6yMJAl
         Ea2tB8EO6xVDkcpato+OYYbpMamWooyj4Kk1x773HgjlUOFyhtp7Caei5B60RUsYrqIP
         EkwH0hWU8gT7DDXexq/0U8DxMKXGkoc7bi7Tru/aYDUNoYzEObvP1zvR+D44noTbCKOE
         uhSzqp0HrWcfmk1H9BZACz4ZK7iRzw5HLOJA9v/a6hdetvyV1zt1MXoQSax3YFd/xZC2
         u99b6del2xMNPmh9ceI+czmQTcAvEXJyFByezipPkOp74AaxHPwlgY217OjlZD72MlCq
         PcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jDjtJ0LH2mOG9+BZqbx8yqqoSjYxW1SBZl9GtzI988=;
        b=BneNX5xQJlMwAh5jE2aQP8SBR9YgcEXJrl5wwKbOuZgP3y5gg6N8J2wnzLpUO0JSrO
         rzbxVqevemGM8qx3gUFE2BZRL3vnVhrU5qOLpnFGTIq9DCwukKSavvAjPl4W3g3xmoTv
         QamXSkkjS6sFS7x49U6zWPZr0QHYtSuntESVGiyHIAXE15lmkwTkiVvugtRhI/cwVBaG
         yU1vw9sSYAf58js0bpJBwg86DgTlxMB4WI5y83RlQfuyHOPD0wdqarWtK+zfhC5/seaJ
         bNWU2Xv76/svMln1/HI0h7RFzb13Ju9NrH8Noe9Am45a9BJmn2p28bbXi3MMZd1qMhyN
         dFJA==
X-Gm-Message-State: APjAAAX05b7qkp8rg45CKO4Re7Dx7wSbG52y0VKqKihBwRU2ZLJWvXGi
        L1zA3wAfuWVmBzamGvYRlAtF7A==
X-Google-Smtp-Source: APXvYqw/4SBhbRUxwhtzItPaL11vUZHZyu0FFeuTOqk4dHHi/Cg7gtxxXqMqYdVLbQnKNKseyzN+nQ==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr4545912plo.75.1578482758436;
        Wed, 08 Jan 2020 03:25:58 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id 68sm3294721pge.14.2020.01.08.03.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 03:25:57 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:55:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Introduce Bandwidth OPPs for interconnects
Message-ID: <20200108112522.afg535ybfxrlypcv@vireshk-i7>
References: <20191207002424.201796-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207002424.201796-1-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-12-19, 16:24, Saravana Kannan wrote:
> Viresh/Stephen,
> 
> I don't think all the additional code/diff in this v6 series is worth it
> to avoid using the rate field to store peak bandwidth. However, since folks
> weren't too happy about it, here it is. I prefer the v5 series, but not
> too strongly tied to it. Let me know what you think Viresh/Stephen.
> 
> Btw, I wasn't sure of opp-hz = 0

I am not sure either ;)

> or opp-level = 0 were allowed. Also,

I think this is allowed.

> it's not clear why the duplicate check isn't done for opp-level when
> _opp_add() is called. Based on that, we could add opp-level comparison

This should be done. Please do that in the first patch as I suggested
in the code as well.

> to opp_compare_key(). That's why you'll see a few spurious
> opp_key.level = 0 lines. Let me know how you want to go with that.
> 
> I could also add a opp.key_type enum field to store what key type the
> opp entry is. But looks like I can get away without adding an
> unnecessary variable. So, I've skipped that for now.

Not in the OPP struct, but such an enum can be used for helper
routines as I commented.

-- 
viresh
