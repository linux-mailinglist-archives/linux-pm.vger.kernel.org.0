Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F3E55FCC8
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jun 2022 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiF2KB4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jun 2022 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiF2KBx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jun 2022 06:01:53 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94D73DA7E
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 03:01:51 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x4so14654953pfq.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jun 2022 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=06ETpuMkkHvgkjlRcUOfW3Fbdi0cQVfE/Mqnw8Cfz6c=;
        b=Z+DdzGQCOPMWgnRlG7eFR3++KN2JGZInwRICpUOLLpqkx2IqLJFYiPE47vbXS1M7JZ
         k3dBjYEgqg78UAgVBFY2pwz5JpwYtepipTJYYxwuIoIUuP5JxEfD+nfiFcBKqeF03ycP
         iXM2XlNp7Yy8tyP8WcNfyxrCw2Rqkywr09QZhnjzI3P0NvFFLMoEvoJCIhQs/n+r9q0C
         nftPKoUNQHGMtw6rkvD7cv2qg65N0sWjsgd81B54w4c5ESm5qN/yJl8HsfhfcW5CSyyI
         gshmwI0JOZqQF0PNQmq+IM/Fc00D2tISqKkflocSf8xRPkE8kRhbSXyNcERixq5pUFZs
         VDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=06ETpuMkkHvgkjlRcUOfW3Fbdi0cQVfE/Mqnw8Cfz6c=;
        b=qIDFFw3T2bDRtYmXgSGuNsRvD1xE/ujUiWYqxdt0v3h6G8iyl+Qh848+tCELBqw4J6
         rjTyDSILlim9Jrjc8Qb0IgBOOcnfuPpyrJKIDMv6do9OAe6X4ZNGtn/sNAFVg75qTT3b
         K/WMMPH2199HRDSV6zzosb1BoQFH6kmLSgDbfxBblvkpDZwRvyrx1SPO9wtlpq0xCt06
         teR/Kkl35BQyg9JjgcYLfD9QENC5pgAL2SiH2/ZcqECPDpiChHyQav/uvSiFWY+Z9GiK
         slcKsN6uqyHtEtfrSJ+qi0WzwKchIvMXvJfUDeVV8GZlDOhATps1v/UThCgyhNcoWY1m
         jXwA==
X-Gm-Message-State: AJIora9Nhr0lk0ZeqIF7XEMGsHOngqkKiVvxpulwor0A9hdIN8nfeeZV
        8bOH6DgF6TXusXv6crNq+p2a/g==
X-Google-Smtp-Source: AGRyM1u3TUNiIcqmMzXOhJVXBVjarrFFI/oXzgv9p8odXVYl86MN3Ot3cWjxvyYtnW9QUQTXGp/5mw==
X-Received: by 2002:a63:481a:0:b0:411:7951:cbcd with SMTP id v26-20020a63481a000000b004117951cbcdmr2346233pga.66.1656496911163;
        Wed, 29 Jun 2022 03:01:51 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id a8-20020a656048000000b003db7de758besm10992476pgp.5.2022.06.29.03.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:01:50 -0700 (PDT)
Date:   Wed, 29 Jun 2022 15:31:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     daniel.lezcano@linaro.org, Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-pm@vger.kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Energy Model power in micro-Watts and SCMI v3.1
 alignment
Message-ID: <20220629100148.67kevfelqq7d23n5@vireshk-i7>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <be793e51-0d89-7afd-e122-ec929a1130e9@arm.com>
 <20220629095302.bi3xx6yicsnjeff7@vireshk-i7>
 <1072cb84-4097-0cbd-f980-a864ea851b0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072cb84-4097-0cbd-f980-a864ea851b0c@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-06-22, 11:00, Lukasz Luba wrote:
> Thanks for fast response. It would be great.
> 
> I have 2 ACKs from Sudeep for the SCMI part,
> but I don't know the status e.g. of DTPM
> current work which is using the EM milli-Watts
> and does conversion to uW internally.
> I hope, I won't make issues to Daniel's work with this
> change.

Daniel, do you have any objections to this ?

-- 
viresh
