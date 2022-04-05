Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274914F4890
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbiDEVmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Apr 2022 17:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457654AbiDEQZ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 12:25:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8D856221
        for <linux-pm@vger.kernel.org>; Tue,  5 Apr 2022 09:23:58 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d29so14079251wra.10
        for <linux-pm@vger.kernel.org>; Tue, 05 Apr 2022 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=uNzlJACAD9QnQke3SSToK719ANjVE0c+mTYoEIGVJ3w=;
        b=FtzoNX+p+eICP1GeL76Sx1j6Q69n269E+aeA6jJLGrFL6Z08neX/EzklEDytwMowAc
         6IGi63GFlJoBulkw842hKVr8P7vnoUja0wsbRJnRSRW8nkZn3D+IVzPe71qJshXMmcc8
         4mesEVSZi0NGqA5xf7DEAk6hClubcWMy4ASv1yCmg+LNN005peFxsWlr42CiRRQTId59
         +1p3SB+o763lf1e7Dr5xKXiLXzDziRCVqPVQW96tyULq4Ea9jai2SoU9UzANj5Y8EeGE
         Gl0pcpn88/DGzbQQhfzcbqDfw+/uLPCSzfofPTv/cvrXzIQr2mn6Tyo2j0rMGsQUZKr2
         dLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=uNzlJACAD9QnQke3SSToK719ANjVE0c+mTYoEIGVJ3w=;
        b=Kq98a++NVJuV1sf68zTUgGUX/++COdP0Y0R6bg98ziikGU52OYw7WalCJdyQ0LMT9b
         v+BeZ5UtnkdaKCgk2hHARZo1u2DfbdPdxtCyu54Koy7c2a3D4WCUMZ82r3RTYAeytDmk
         j9TFBy70UeozIkNoYpOTqkWdpe36sjab0jpWJjE7BgcfeMNdCKMze6qBLcFCdTthhjEk
         smm1fK9BgK5IdyYVPbcLCTmn9klC98GQn9RiXKh+NxKE1RLvL4dz8cm7ZmoA32sz+1Wp
         sj63YI6NWkdEXnMkuA86KPM2y4D6HqCyzkvKN0HwJmjHZG2mh2lcteMdwyxsQejaehwS
         RkjQ==
X-Gm-Message-State: AOAM533Mb3QIgEN1q5aYYIfyeGtWLY06XRXL11lHjy5DHtVCfa1IvXxd
        bVh3E6cuQLi2sn19z0K0qCrKIw==
X-Google-Smtp-Source: ABdhPJzzhmRA9+E0CSpPhcpL5E+BndcfoJdIYKoIHzgSqgoo24dqN2UZdFW4TvGCbFvV+l0ZTLqSXg==
X-Received: by 2002:a5d:508d:0:b0:203:dac9:d301 with SMTP id a13-20020a5d508d000000b00203dac9d301mr3300013wrt.441.1649175837381;
        Tue, 05 Apr 2022 09:23:57 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:104:1924:d86e:ac5f? ([2a01:e34:ed2f:f020:104:1924:d86e:ac5f])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0038cb8b38f9fsm2780829wmq.21.2022.04.05.09.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 09:23:56 -0700 (PDT)
Message-ID: <b4f8e639-bd39-cf08-8cad-b18aa926036f@linexp.org>
Date:   Tue, 5 Apr 2022 18:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Alexandre Bailon <abailon@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, mka@chromium.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <7hlex0s6ag.fsf@baylibre.com>
 <b627639a-d050-66af-31d3-c6a6c04eb4e0@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
Subject: Re: [PATCH 0/2] thermal: Add support of multiple sensors
In-Reply-To: <b627639a-d050-66af-31d3-c6a6c04eb4e0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Angelo,


On 05/04/2022 14:14, AngeloGioacchino Del Regno wrote:

[ ... ]


> Hello Eduardo, Kevin,
> 
> I would like to add that this series is not only benefitting MediaTek
>  platforms, and not only Chromebooks. On some Qualcomm SoCs (from
> SDM845 onwards, if I'm not wrong!), downstream, there is some "qti
> virtual sensor" driver, which is addressing this kind of situation: 
> on these platforms, averaging, min and max (and some interpolation
> too, but that's another story, I guess) is happening and that's used
> as some advanced way to ensure that both performance stays high and
> that the device is safe to operate. On these platforms, this is done
> by evaluating CPU, GPU, Hexagon DSPs, modem, wifi and (modem,wifi)PA
> IPs and deciding on a thermal throttling strategy.
> 
> You understand that, while this is not "excessively" important for a
>  Chromebook, which is a laptop, it may become even a safety concern
> in devices of other form factor, like smartphones, where there is a
> very strict thermal headroom (hence requiring a fine grained thermal
> management).
> 
> Even though, on MediaTek, I guess that the primary usecase is 
> Chromebooks and this kind of mechanism is required primarily for the
> LVTS sensors that are used for SVS calculations (read: better power
> efficiency), the Linux community is huge - and, with this kept in
> mind, there will probably be someone that will like to upstream their
> MTK smartphone for a reason or another (I think! This happened with
> Qualcomm so I guess that it's going to happen with "any other
> thing")... and that adds up to this problem being a safety concern to
> fix.
> 
> Of course, I agree with you, Eduardo, about the needed cleanup but,
> for all of the aforementioned reasons - mine and Kevin's, like him, I
> would also beg, plead and grovel that you consider merging this
> series as a first phase, and accept the cleanup and use-case
> expansion as a second phase.

I'll take care of the cleanups and then respin Alex's series on top of 
those.

Thanks

  -- Daniel


> P.S.: I'm adding Marijn and Konrad to the loop, as people interested
> to the Qualcomm side of things, and mainly upstreaming smartphones.
> 
> Kind regards, Angelo


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
