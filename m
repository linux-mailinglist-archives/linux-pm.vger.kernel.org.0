Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296952337A8
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgG3R1l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgG3R1l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 13:27:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04278C061574
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 10:27:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f18so25664282wrs.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2020 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7da/ss4rSG+lgk0T6fOXVE8VXppLRzXndYSSdH0a1Ig=;
        b=DbOcCj9btVmLSdcsTYFGFuRMuQ4whAGpf3Oy2nk02rAdv3w8lY6Q4UM+w4/yEU3+zn
         Gs1AVuPuLsL3AuGl/+18M7Wl+Oeqclt+9gConXknYvzUTXoPKREKaUNdEILcHDISis4Q
         yXVHvp+6CPGX9E1AhXzCSlHnq2u8qrZpjGsbascpQ2dvR2BdM/AFY/2R90+BSWbdZGlF
         Ssq3652XdSXsYGRmgWzxB9D7vK1beGc2BHx4QGsWbwb8Pndo3iGIgpvTksulzh5eMHK8
         b23gNeUSHVR9mILntEq6P7HgvLmhKYVAglaVc8Bm3EomqnJQ5A2lyoc+Iw8KjZ7SY1Y4
         8VmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7da/ss4rSG+lgk0T6fOXVE8VXppLRzXndYSSdH0a1Ig=;
        b=RoYSlpGCs+YWCKXOOTVFYOc64VsTQN/52z8Ta4695Ci76VBiurSIte1qqqjNxg1xnP
         B+2dCjt05P4xMH6GYTrpU45miDqEPD9ww855ldFhISHqG/ImaNT4CWrzK+vAeI5gw1rH
         hhqcJQKU6chvS8BBn8RPdgiuKoL/QoEeHV3Egxkny9MMZDV9hAtSttvaSz85gq6zu37E
         VRR5tYkiCR9gjo1uRxDLeew3yIKgq20hqUQeqfVcOV/CIpxs+QX0jfabfqHFAwFC9wUE
         K3AthvKxolKahcC4Elgb0ghytubkWJN4EuyS9mmw3zMNEKNRd+kNCcLDWLCz9sWsh4jD
         j/BA==
X-Gm-Message-State: AOAM5301zQV7pSOaM3GLRBlplNzZ3SfjITDXxksleyEDOYoeI1+S51QX
        91/MZzHzcBXvnukRl3j7FFDI7Q==
X-Google-Smtp-Source: ABdhPJybx/TN/H+nU4/QV7kSyNeL6LaO1WOZASCP03SNCDQRsrM6/PdO+aOLmXzpF+BvBc01QNleNw==
X-Received: by 2002:a5d:618e:: with SMTP id j14mr3863180wru.374.1596130059428;
        Thu, 30 Jul 2020 10:27:39 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e484:a7d1:6931:9059? ([2a01:e34:ed2f:f020:e484:a7d1:6931:9059])
        by smtp.googlemail.com with ESMTPSA id o2sm10103853wrj.21.2020.07.30.10.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 10:27:38 -0700 (PDT)
Subject: Re: [PATCH] thermal: Update power allocator and devfreq cooling to
 SPDX licensing
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, amitk@kernel.org
References: <20200730165117.13998-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <67c3f5ca-1aed-0a3e-ba0e-586405063dac@linaro.org>
Date:   Thu, 30 Jul 2020 19:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730165117.13998-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/07/2020 18:51, Lukasz Luba wrote:
> Update the license to the SPDX licensing format.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
