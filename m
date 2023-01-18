Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BAA671282
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 05:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjARES2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Jan 2023 23:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjARES1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2023 23:18:27 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637EAC67A
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 20:18:26 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v23so30765539plo.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Jan 2023 20:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O03edEju3xNBHfHUVApCGJHSP3GZsUCwUrXGo331jWg=;
        b=pqy6AtsjAh1flHEp+yVREN4y+SsHGXanPzd+GifPM6R08b50cq8rSZkseMdw/LmLU4
         EpeChP/hYNe8oIcFAcv8/cbXXKOogytinur18tW3+lYNaIp3i5+z9jvnKFgw+wtqXUOV
         JlWvBXbWxMukjG2J+4/DaL57xnKP1xm3QP+j4EocrwPQ5HnS3T6NdROiY5G9b/NhVEoD
         T4i9oonMi0s65HoNy8F4rsoInTReu8H46pNiCM4kzFtZdNd0fyHKHNolDIa+E8+clvjp
         YXJWAvG2iol8CYI3OeNW96urSkboZBL4R38Uh9W5nWx/9EB4mRP3srpO6Wf6JsqdGdh7
         855g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O03edEju3xNBHfHUVApCGJHSP3GZsUCwUrXGo331jWg=;
        b=5IZZIP+mwqYiA+zUXmOLhixrihYlGg3XgccjLblPL1wPna+DzBlY3jsPICiwiuhAG3
         xjj6WvSEtAK4vfKT2lZcrCR9nXMfxZXfBYHjHtdt/qBKlNuSu2SXq1+/H93dQzgDIHLk
         aaOaYKmp/FcGovCwU6l031zkWpU3YvaE/KJ0YtbkTAZnuaeWCcfY/+HLcdoRAGhUPSm7
         dbaCnjEoJsUyjzwDtEi3VvG9sLA1SY8No2T9avRRXyD4tZT8kz3BWjhYVuu8JgLW9Np8
         xO8iGt0mIBLuUFp1g6oAIf5NFwznGq7ySzNP6HB9nTghs/9sbPa8I1RuV8Unw4woDT2a
         eGWQ==
X-Gm-Message-State: AFqh2kosqtf3Leb0HgCHVieBJXJhCHtcFUy/7EGmtX4OX18G/z/9j6EL
        /z4XB0hQr1MygzJmMrTfGA5H2siVvFSbVqhN
X-Google-Smtp-Source: AMrXdXsdxq2UrqHrWVz/d9oIcLgR+P2iWo46IHY8T4MOSxzMUnhZdkFCX8qLkPNFH0BtQ+c1RUR0pQ==
X-Received: by 2002:a17:902:9343:b0:194:4a2b:d7e4 with SMTP id g3-20020a170902934300b001944a2bd7e4mr6520564plp.17.1674015505875;
        Tue, 17 Jan 2023 20:18:25 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b001782aab6318sm21921982pla.68.2023.01.17.20.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:18:25 -0800 (PST)
Date:   Wed, 18 Jan 2023 09:48:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3] thermal/core: fix error paths in
 __thermal_cooling_device_register()
Message-ID: <20230118041820.tdaq7nmgsunlm7zt@vireshk-i7>
References: <20230112154721.452292-1-caleb.connolly@linaro.org>
 <20230116042326.l3kyd55lbw4dfocm@vireshk-i7>
 <24afe142-f835-29af-fca6-d00e864b0c82@huawei.com>
 <20230117043653.4n2dfruh36x4uazj@vireshk-i7>
 <CAJZ5v0ihaNHneyRwd8nWYUhGKGRpHrVFi7gJsp_g9MX=oLc9Eg@mail.gmail.com>
 <26cc4bea-1e0b-2d41-fbf3-aae3ab6dfcfe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26cc4bea-1e0b-2d41-fbf3-aae3ab6dfcfe@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-01-23, 18:11, Caleb Connolly wrote:
> it's a fun one:
> 
> https://lore.kernel.org/linux-pm/20230101174342.58351-1-caleb.connolly@linaro.org/
> 
> I don't see any issues with this suggested patch, however I don't think
> I could comfortably attach my SoB to it given the larger code reordering
> and my complete lack of experience with this subsystem.
> 
> Would a Tested-by be acceptable?

Sure, lemme send the patch(es) formally then.

-- 
viresh
