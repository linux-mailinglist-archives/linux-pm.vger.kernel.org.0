Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DE7BA64D
	for <lists+linux-pm@lfdr.de>; Thu,  5 Oct 2023 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjJEQdL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Oct 2023 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjJEQce (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2023 12:32:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775E24870
        for <linux-pm@vger.kernel.org>; Thu,  5 Oct 2023 04:20:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so511037f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Oct 2023 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696504815; x=1697109615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4AE5jS4qjwXCMnOlOFtdJ9RttCSKbWymcLORudPBgc=;
        b=vITy67iqXCawyJRrBYTbANj04Wqd82i9f+X41xRdVLpr9q1nrjp3lsGFiHlsCH4/Mm
         gYaoQefcPxWoF98ga9pncX77lQMPRQgXX5DlFeNEWdkrD7jVEA4VmiAonOKryk1TfyP8
         Xf/ODAA7V8B2gZkU8C/xsfqPlqxWBhEehk7ysxdNpqytvgNkJj5CllMfDprn49pUEKT7
         OlgtR6JFLaxWz3LozZJ5G3+wdPB+at/WpKJKi/DeZqjdgNeEx3aT5HuOoDzmhwmoJ19G
         RrDWYo6ObHQwOXN+QuZunJj8p0F5Nl5JdS7rlbIFcT3WQLYQL6NMEKxcncm3Le4s1NKf
         kqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696504815; x=1697109615;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4AE5jS4qjwXCMnOlOFtdJ9RttCSKbWymcLORudPBgc=;
        b=UjNI5eUMKIWSvj3bc20TZ4zH9+fvRtKvXp2u9Tf80Gcfr8nW74jCBKDIKfFmxTeGEq
         11lX0ODiOCuUy7PtsYHfL1msbn7/0cCGrpZlBGqSgpruEJyVrg4p1Fv3MDsizHdUllvJ
         VCVWhvpNh1iuHUZApWzbfKNttAaNJyNol7bIj3axQH0WA8PhUs3YK0liByAsqKGN71pp
         tVmYtv4J8kiCFuqAPoyEzy8EnGDygEJTZlgqI3KPZlSbBWagzpSrspljo4LzY7HBIJzo
         VceZm+oFG7TFERzpcXwdOuPUW6U0TDvTZMY6iO2qPHUga63YDlXGRkdY7CbvL4h29bKI
         Ldfg==
X-Gm-Message-State: AOJu0Ywx7VN2XyOWx5mOyOt8DunPV8xDxI25zOsAVQ/FOCyK9aBBRqgC
        gJj66LGvfUOyDwKmuY+gJniJ8A==
X-Google-Smtp-Source: AGHT+IEI36e0d7npO9gHvSq0PCK8REknqrsXlLxeDQM2Vg3iDm3n0GAUq6RQUC7RZu5soOlpwzCm6w==
X-Received: by 2002:a5d:6387:0:b0:323:1688:a70e with SMTP id p7-20020a5d6387000000b003231688a70emr1084141wru.16.1696504815109;
        Thu, 05 Oct 2023 04:20:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8bb6:12b3:863a:e5dd? ([2a05:6e02:1041:c10:8bb6:12b3:863a:e5dd])
        by smtp.googlemail.com with ESMTPSA id t25-20020a1c7719000000b004065daba6casm3539418wmi.46.2023.10.05.04.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 04:20:14 -0700 (PDT)
Message-ID: <d784edb6-9a95-b30c-6f55-a1daccad2f9e@linaro.org>
Date:   Thu, 5 Oct 2023 13:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/6] thermal: int340x: Use thermal_zone_for_each_trip()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <4846448.GXAFRqVoOG@kreacher> <3532950.iIbC2pHGDl@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3532950.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/10/2023 15:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Modify int340x_thermal_update_trips() to use thermal_zone_for_each_trip()
> for walking trips instead of using the trips[] table passed to the
> thermal zone registration function.
> 
> For this purpose, store active trip point indices in the priv fieids of
> the corresponding thermal_trip structures.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Mo changes
> 
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

