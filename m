Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D37AF644
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 00:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjIZWX7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 18:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIZWV7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 18:21:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A0C15EBD
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 14:33:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4053c6f0d55so97899535e9.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695764002; x=1696368802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZieSTgMmUxr/NfrkjbwSgNBNg4r3Zk2KAXB7myr0pX4=;
        b=LeF/fgiUcq3PBpwMTeTs20NQ+6zTGiMrhFzQvGfQOczpdv4mB/bqLouRDav9rC7inT
         YR2FQ54CuvN836AaA5aVTi5Rm8GIEuyynMklnF+Kb6RDkxVYmMcAhwGDf6NH/+A7K0WU
         +3Y5w3MB9mkvtFLgVqXt7hzcsemtvDtoFTknkmYrX3uxKfBlolRivauc8GyFI7xiV2LP
         hsT/9evepJAG7TRVf/FEEihpLOHHiuH+q5tqB1iPB4pPumKMNzqxkLUd+oBJ5AtUW/FT
         EAhpsc312xu8C3ArStLw3v4ibgh6J5yKcSyJOTJkfkcZ1cB5/kbqbawvziF/4MeUwgH6
         LPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695764002; x=1696368802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZieSTgMmUxr/NfrkjbwSgNBNg4r3Zk2KAXB7myr0pX4=;
        b=klrnItESpuwdGJQ3fCpx3hDqsORFa8mNMY1jTXuqN9C7lcxYJy7YPKqc+U3MN6AElJ
         wt+jv/kVi5mx1ExS09OcYtEb2DSE+0A3AGBtCTK1jlt4cd2igadD8w48r1pk/7MajMjR
         mp7pNQrSeLv8qcIyokmugbpW6he4rZrUAR1KKKkiDINaY2WSbMzmJt5CxSTTlO06GB2H
         /jgrJRQJOsexarhH1eQ3jKxvAVbOlaAmzcYYjuE1GToLDhyOaQoz3nTI5hrO+XMi0J6B
         O5DRpF8I+9QXeitycgl9iYgt3Yt231wtBta6rvc7UmhvJaDZp9LMYs8uNM+0ITNrNdMm
         TUcA==
X-Gm-Message-State: AOJu0YxnYOClUNuViChC+DuA3kpqtH4MlUayYaQCHFmI8/DIKyWaNCCk
        SvnWluuO1RYTegCWMhlktgg4BA==
X-Google-Smtp-Source: AGHT+IFOOMgkDp4RpIOH4fcxCTjyZKjvfOrC5prP7B4X4f0NsVWVwuRAKhYSlLCC9KDKAJF1jpA7Mw==
X-Received: by 2002:a5d:4fc9:0:b0:31f:f99c:6009 with SMTP id h9-20020a5d4fc9000000b0031ff99c6009mr11016450wrw.22.1695764002559;
        Tue, 26 Sep 2023 14:33:22 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id m16-20020a056000009000b0031c71693449sm15709182wrx.1.2023.09.26.14.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 14:33:21 -0700 (PDT)
Message-ID: <44f9b368-395e-eaf7-b548-7906b33e039b@linaro.org>
Date:   Tue, 26 Sep 2023 23:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 02/13] ACPI: thermal: Collapse trip devices update
 functions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <3534976.iIbC2pHGDl@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3534976.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2023 19:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplication, merge update_passive_devices() and
> update_active_devices() into one function called update_trip_devices()
> that will be used for updating both the passive and active trip points.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

