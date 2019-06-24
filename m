Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2E500DD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 06:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFXE5a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Jun 2019 00:57:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36309 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfFXE5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2019 00:57:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so6186451plt.3
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2019 21:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LzcRJpigxT5MGuTpMW9ctxhMBXABXFzOsOqSmkIMVZs=;
        b=aBXS7Cm1olXy+laKPXiQxa30hxieGkALh5+gO8nLnUI5lyVhz/oD2UTscaPgIbqFbp
         Y7Ffvd1JPoITsXzJqRKAFI9deCx9SlqjJH+MgVXINt0u76Dnpkk3bIR4gVcUYRMeqfpw
         g03GE6AV2zMpAZB+sHIwbfg4fiqUHiOUgjOLrox+NP9N/MiP75LS0ZCpbFopzYWhYRvH
         MfTajMnZITjGnwnXVe0GYFcym5RV7BZQ30gdEnWlwi+CZDHw7YrnieGZifKQ/QjA4z8v
         6x4EfX9eX8E9HjA4hWkNEj+hEZxEXuxc8U4m+mx8ObPMA3OcHmiML+w2tLH6csDuTE25
         qpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LzcRJpigxT5MGuTpMW9ctxhMBXABXFzOsOqSmkIMVZs=;
        b=qEhfUbzzPuDik93h4P7WfXsq//TduJA7UX+fhNJAUlRAdGRG34kqoiWawJyqKYjkYs
         KGHWzrqMeuHGknmkVMH0ETQZ5cV8sQzIqkkx5A1a2E33WlvLxmCorc/hkhtyWNhWIwN5
         ijaVvrfgSG558UHiT0EKgTyZDmdsSy7mH1E4DJffbExjaTXmIOAgmAI/676SHdnoLr88
         9TWILshZBWTadsQmzs0JcpG/Q/vDs2UTgFLb4rEQ0fJKD2a0vP5tifBDtURK6v66Aliu
         QP6W9/ch+MkMfOrtpDGt7NkV/tpGUAvE9pXuOwF1sM/eLCPhucNuKRB+oC4DfCm4jilp
         n6ow==
X-Gm-Message-State: APjAAAXwvTHkyR5xKr9enaYqKJL48bjx4WtXNMMkFm5gMVLc42v11AiV
        73t0BdpmgZpMdoXtTJ2UVe5CEw==
X-Google-Smtp-Source: APXvYqwpkNtle9sTLmOxKKkYez6T2CQpCkhZX9e/+Shu8srXtG6COfcrFldWGtjRJbLpIz5bAo1G8g==
X-Received: by 2002:a17:902:e287:: with SMTP id cf7mr54710956plb.32.1561352249158;
        Sun, 23 Jun 2019 21:57:29 -0700 (PDT)
Received: from localhost ([122.172.211.128])
        by smtp.gmail.com with ESMTPSA id q4sm10420766pjq.27.2019.06.23.21.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 21:57:27 -0700 (PDT)
Date:   Mon, 24 Jun 2019 10:27:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND,v2] cpufreq: s5pv210: Don't flood kernel log after
 cpufreq change
Message-ID: <20190624045725.mckcpb5kvkug33p6@vireshk-i7>
References: <20190621101043.10549-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621101043.10549-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-06-19, 12:10, Paweł Chmiel wrote:
> This commit replaces printk with pr_debug, so we don't flood kernel log.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> Changes from v1:
>   - Added Acked-by
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
