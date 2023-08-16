Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1A77DE80
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbjHPKUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbjHPKUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 06:20:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD128273A
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:19:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so42668865e9.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2023 03:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692181193; x=1692785993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmjN3JAjelzq+oWKC3jPF85P5AnIEkLR/C9m0jYX4vM=;
        b=YXPPVHRVFwXdm3TSrCFNOVuLoDvISqwtkrglVRFPC4zNLWsoKFOSyWTKToIefM6lhm
         Vi6em14I1z+sOgVpEdxUKQHFfkT3O9EjaCt2nPnQjxlfD0pU0yvqRoW7rh+n5EKSTYYc
         rCXHlESa9ZU/o8gqrfeWJ3JYHkrfSV2d9MO02xq4mTFdpyMyL58EkDwIewu2fjWFxbXs
         62AyqKYtBPzL7hrfFUelts97DGx2QLAOn3WqV0/y3GdaT/acLKA6HZAooHTQYGtQSao2
         UCDfFa6Q+M704TESkYmQuufsDedo0OTRpm8Ay9Nwi0L36z7D5O9JtC6SPEX98L63p8m7
         o3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181193; x=1692785993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmjN3JAjelzq+oWKC3jPF85P5AnIEkLR/C9m0jYX4vM=;
        b=cA0jbQ2EIr5bvBMLmaekYso6X7hWxpV6ceSTLyZ294BUIrp8pwivTnhd8paDt/gXDH
         qu2yqIc6vketwapuNREN6I49uVxeTM/ibEM9xNxBBGAgGywrTQ5wjXFLkvfse0bTU6oj
         kgdKCdiP41b1EVInMaUA0IStbUWMO65+dvIBvqh0BAsiLv3LSXxzZbupsIps75hYFbwb
         TMwGFqxSCNw1SHIKh3/pJOxFoKropJz1W/1G3mUF9PIq+POg6vcFDWMY8uS0B8ekZuUY
         UYEXs+kbjTKex1NQYzoMgXT3/EgtmsMC1mEThHQooqichsCM4ybVxie1c1WP+/QdQV9J
         aGJA==
X-Gm-Message-State: AOJu0Yx/BMqfnJaRT/qgTnI7W2YsFdDHxpCp84lKISBlQkaUy4Jw7VN/
        +flHp9uPpV8MzfvUxqMTk3M9dQ==
X-Google-Smtp-Source: AGHT+IFVDRGpt5L1nlKFkHgTOLGxaGC3WcO6iUjQ7gcHotgVIxXT8JlEnbSH9icdSGeNNpKXcY3VLw==
X-Received: by 2002:a05:600c:364c:b0:3fe:1c10:8d04 with SMTP id y12-20020a05600c364c00b003fe1c108d04mr1250479wmq.19.1692181193129;
        Wed, 16 Aug 2023 03:19:53 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z9-20020a5d44c9000000b00319779ee691sm9780198wrr.28.2023.08.16.03.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:19:52 -0700 (PDT)
Message-ID: <b891db1f-c3f5-21e7-cb0d-4f001c4af588@linaro.org>
Date:   Wed, 16 Aug 2023 12:19:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: k3_bandgap: remove unneeded call to
 platform_set_drvdata()
Content-Language: en-US
To:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        alex@shruggie.ro
References: <20230810112344.3806-1-aboutphysycs@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230810112344.3806-1-aboutphysycs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/08/2023 13:23, Andrei Coardos wrote:
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Also,
> the private data is defined in this driver, so there is no risk of it being
> accessed outside of this driver file.
> 
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

