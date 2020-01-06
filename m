Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A24B130DFC
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 08:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFHbO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 02:31:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39247 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgAFHbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 02:31:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so26474343pga.6
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 23:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJxkFJPOk4NXRduzmH/EPxDE/CojMKX6nSv2Cv6HZCI=;
        b=guBeeF9h7hO0kllEOPxa/svmSgTrGzPsjP+d7PYa4em3Z+CN4u4o1A6L5va+rmWXBo
         gFcDfENZ0PHEhQInq+h2VNuy/BUR8w8l78CplRkuQzEHO3eZdAsAZvrW1dVL3/apMkQV
         gsUuhe57vPcmNT7a3chXNhfYFKG2OVbMVm+NTkexPTV+zsOoz5QccdSVdEM2NAfnqJ2X
         jewcNPnJ0labD2xMWP4se5gEYs1rw1uOgQ4X7JuejEIcB58FWeu1YAqhP8r2WW2S7dyi
         q47yIbt0Z7LJl1/QnC00UgWWQNeHG+kQ8W03Qff2dFGaOcxSzlcOMPXODFVwxnChNh6l
         RteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJxkFJPOk4NXRduzmH/EPxDE/CojMKX6nSv2Cv6HZCI=;
        b=nve7PG5qTIjOpMfNpOqbDQpecbpmZLDlu3KhN2MhNosl/nOdaQqh/+/W8TKq7SXiX2
         bWtgQCMtQ7sdt0wjPqwD/NKLAVnULCn2T2YI0ArzdE23FNC0frFDxvmKy+9/KB6knB9H
         Fvhzg7L+AhB/7VFokpRP4t7ij+GR1hzVi79IXj1+3HzA8ACNF8lT6FsQVUtKZ+s74B3q
         V4lU8xlg0SFyqCbRaObsgAgP5HlasHQX50raugIVw4v29UYk0klM4TLN5gE59R3xX3TD
         UU0LyUSw6KWVrJEEdj4++dLLQSgCAYGJemtjzTNx3AQQy/D5ZLT7zjN4KqTEFaLV6c3M
         kkKQ==
X-Gm-Message-State: APjAAAW9ihxD+f3rrSlsLOTY7HRPclm01/FduHouQ9+inYKCYzsiN7f6
        JPwEd9vAGGiuaU4OnoeDAI6b2g==
X-Google-Smtp-Source: APXvYqyOO5ovbIh9XmJsORrDjsz2C22z/ci4/3OWzknjCNQSXMMAfW/K01McsN3aX8am6wSHGM+WqQ==
X-Received: by 2002:a65:4c8b:: with SMTP id m11mr111865915pgt.208.1578295873320;
        Sun, 05 Jan 2020 23:31:13 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id k21sm63505992pfa.63.2020.01.05.23.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 23:31:12 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:01:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, f.fainelli@gmail.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] cpufreq: brcmstb-avs-cpufreq: avoid potential stuck
 and UAF risk
Message-ID: <20200106073109.ndm7enzyznquqps5@vireshk-i7>
References: <1578228650-17157-1-git-send-email-qiwuchen55@gmail.com>
 <20200106055637.zq4icl5klg4wpvkx@vireshk-i7>
 <20200106070910.GA17897@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106070910.GA17897@cqw-OptiPlex-7050>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-01-20, 15:09, chenqiwu wrote:
> There could be a case as the description of this patch besides
> brcm_avs_driver unloads. Since cpufreq_policy_free() will free
> the mm of cpufreq_policy at the last moment.

Ahh, right. Please fix the other "policy" thing I reported and resend
the patch then.

-- 
viresh
