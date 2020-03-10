Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10FB180B22
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 23:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJWDU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 18:03:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34156 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJWDU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 18:03:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id x3so1760259wmj.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2020 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dYEP1uE4NnVFr/AeDKddTWSxJgA20EPFg2G+JAahXU0=;
        b=I20JsyOJIesiZZQ8aV/IdyM+r4UI4cQUwV9OU88GjMqXQdcGxyWCcTu+TKnMpQTwzR
         8zsRR1Ku3VvKEiqj1/PL8R5Nrk6wcQBvAnxyWKr7fOA7HdZ08IH0zfDTMBnRXrE4sv+B
         1FJbyCwTIoyCOqD2c6zdL2IiWQINHKswybaSp4LQ7NJ/mx5atiVaaCA7KJmFqkI1NxgO
         ZLyx0BgypSHUQzKXHvqeJWj1ZAU41f5jkODNqWwySdRgLuSbY/bjut3UAN1jCydVdFW5
         4q0nzPNiNsFhSQ2UmsMYO7SYzoSm7Xv0C8TZTspbL4HFRap19/7Ybum6IG+LQMJ662fW
         FIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dYEP1uE4NnVFr/AeDKddTWSxJgA20EPFg2G+JAahXU0=;
        b=GTbOtx+sS1z9G0QVTeNXFege5ka15SGMfxluHFrISW0VOOWVZeDOoG/gtD/ldq194/
         pf7NqA2szJ68MbwodFnmCxTjUvpGCELTNmpUO6KnDh8WA5+tLxXGQ1YFZLOM+qyqaEJK
         k4uZAKV1TOThecoS4ExBCPwCEmoUOak3rgmjj/l3vM/hZ50/4AaTNBVp8rAMqLcquNnl
         GIotbet01b8Es1x8RixxhLKrebIwW6SIdEbA0Kem7jinxJjeDf9rJNk8WwK6NdUBeMAl
         oQP8sCEgBG0g+23iQBJ88Ek6mfQi/9f81FamXdlg24s5cScKSCcODAkL69HB5Bzr6iMP
         qCtA==
X-Gm-Message-State: ANhLgQ1U+J2ElEDGjuSOYl+p7SwNtPckLbktNVLEWlrHSULHTES9VeJQ
        +dLeWf7Brnax6B95GBvJ1TF9Jw==
X-Google-Smtp-Source: ADFU+vsFsnumgp9VoOGVYqCrNLZ5ay6csw80CWgZBfUy0rM6bs6wjkEgt0Ofqq4WtgfmKA4Ub4RhiQ==
X-Received: by 2002:a1c:4e14:: with SMTP id g20mr3853268wmh.143.1583877798471;
        Tue, 10 Mar 2020 15:03:18 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w67sm1892315wmb.41.2020.03.10.15.03.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 15:03:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>, SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list\:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list\:ARM\/FREESCALE IMX \/ MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
In-Reply-To: <CAL_JsqJAxfL_Q3HYHk_8VeefdXnhYT7kcPe3F5Gzk1Vfj+xtww@mail.gmail.com>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com> <7hsgiqra5x.fsf@baylibre.com> <CAL_JsqJAxfL_Q3HYHk_8VeefdXnhYT7kcPe3F5Gzk1Vfj+xtww@mail.gmail.com>
Date:   Tue, 10 Mar 2020 15:03:15 -0700
Message-ID: <7h36afn9zw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rob Herring <robh+dt@kernel.org> writes:

> On Mon, Mar 2, 2020 at 10:31 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Hi Jianxin,
>>
>> Jianxin Pan <jianxin.pan@amlogic.com> writes:
>>
>> > Missing ';' in the end of secure-monitor example node.
>> >
>> > Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
>> > Reported-by: Rob Herring <robh+dt@kernel.org>
>> > Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> > ---
>> >  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> > index af32209..bc4e037 100644
>> > --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> > +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
>> > @@ -36,5 +36,5 @@ examples:
>> >              compatible = "amlogic,meson-a1-pwrc";
>> >              #power-domain-cells = <1>;
>> >          };
>> > -    }
>> > +    };
>>
>> Thanks for the fix.  Queued for v5.7.
>>
>> @Arnd, @Olof: you can ignore this one.  I requested Jianxin to send to
>> you thinking this was a fix for something you already queued, but it's
>> not.  I'll handle it.
>
> Someone has what needs fixing queued in linux-next, but this fix is
> still not there. Somehow it seems like features show up in linux-next
> faster than fixes for SoC tree...

The fix (this patch) is queued in my 'for-next' branch which I pushed
yesterday.  I guess it missed next-20200310 but should be in tomorrow.

Kevin


[1] https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/log/?h=for-next
