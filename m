Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270F1672A48
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 22:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjARVTl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 16:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjARVTj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 16:19:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8691BAC8
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:19:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so2297302wml.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 13:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uivnTGhuUiDygElM6skS9T0GVNz+gyMSdrSV+1zs6V4=;
        b=pXj0eHzTghq5osO3kKNy/+ulHubzVMYlQsOWF/rT7rgFT81Eue94ARr31Bpev/hoNv
         To+26oKTiORmE7bwLhOFdRuJ8uPDoUbWTB4z39IUcG5AwiBE6+FrMe/Umi5hWwa4kBsC
         AvvRBQITqrgAXjSE7WoVP0uCerQBXGuRWHd7lkReFwqJxLYuXZa2gTEGaZzyJGSDS2Zf
         sowDoPEKqjTJxsMF9KhHQQpIQJcK8+Y1j5vjdHy3dpOLZZRt6BCgNMr8x6OOUMVxMhlD
         xj9OWRWwJjm4Dc74QZJzIgzNkziHWSp7Yetp+8nlfqOSChERo5EzCr4rU7S7IEjksLe/
         0c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uivnTGhuUiDygElM6skS9T0GVNz+gyMSdrSV+1zs6V4=;
        b=P/vzne1o1MdcAfaYGuyNMcc8UPOeqnsphmaHRPf44DjhOh1iSeM3zDzsXQyAsY7pHl
         hQBzXDzUw0sPr1G+YRogK/Ny+jt3swbW9JMaAaHwEKfiPVY/dzLycBMpkEzTYO38eAV1
         JvezeJ7G32/BsKqQO+qWlPmO4Oghq3jb/yb7tNSr1yEBu1ftQ9R95BmbCTB9ndjN8UE6
         a5Lh7eHvBSEXy1ILO/tgWvGmepPWVvVf6nrhIWPR+HGwYFQK020BhHkh+nKfkdvVdECn
         ItvzqFCHtzzAfj0OU20r8lavuBGEX7Z/jb+flawIZol9YJSYJgs1etF2fdDpTggdy1dE
         wiTA==
X-Gm-Message-State: AFqh2kr0lyk9OLgVU9mmap5u49lis4+S92+CqhmxZUqZ0kdEBITj+qku
        31Er/K4tFbbJb1esTKBDFGBYfZtKOhTp0NAK
X-Google-Smtp-Source: AMrXdXv3ADEoE2mzuARpyMYElpc/yIl1bJup9l3GE9gQEBMuzWXEvWEXC9+FckaY1ANswyAQyTnwEA==
X-Received: by 2002:a05:600c:3d10:b0:3d9:ee3d:2f54 with SMTP id bh16-20020a05600c3d1000b003d9ee3d2f54mr16700087wmb.13.1674076776385;
        Wed, 18 Jan 2023 13:19:36 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o22-20020a05600c511600b003d9780466b0sm3297419wms.31.2023.01.18.13.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:19:36 -0800 (PST)
Message-ID: <fc307cdc-52a3-e3d9-5078-dfefb552a415@linaro.org>
Date:   Wed, 18 Jan 2023 22:19:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_thermal/drivers/armada=3a_Use=c2=a0devm?=
 =?UTF-8?B?X3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Language: en-US
To:     ye.xingchen@zte.com.cn
Cc:     miquel.raynal@bootlin.com, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <202301181634379503534@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202301181634379503534@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/01/2023 09:34, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

