Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC57091D69
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 08:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfHSG5J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Aug 2019 02:57:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38712 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfHSG5I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2019 02:57:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so507463plt.5
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2019 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7k//502CULWRlumB5LUfrkH+oVCgs4LxV1yBK5FQWw8=;
        b=n8Pzfswhm9FPBsuTbYIHw3yt1vfkqvLayOSdP1/ZW5QfVYXmUG6Uf15GKoYaiwOzM/
         83br5UBUAxGwaXZEhBEF8hvzVqchUhiLfoSEWCUICWSFL+tG7LOQyxisR3JCGkAAtz2f
         9QbVzrNmosPVKq8kNz3DCin3Mebh1i7kdOYyUBR2vdkxgcKVFE86fAMG+nWNzzqVb0Gx
         uHCCEPU948leGvaytsBRo495cS4T3QwuqgTgrXicF4xyR64gNWoumRAoTkT4xbO7sGpl
         KGH9DBNL8U7ANBSyYIJV7f7IGoXaLjiNMLDKIoIPOOFCdKxQdx6zviuTXH5joz29eJND
         wOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7k//502CULWRlumB5LUfrkH+oVCgs4LxV1yBK5FQWw8=;
        b=OCLRTXjb/MrHUu0R+3+KslB3vokPuDoS0shTGHZIyWTi40cDX7gLhSP4TEIp3W5aY3
         vdfaAGVFngbrV3KFG9BcTjTLgA+Mweo7vISBG/ny3Ct66/EPcCoobNq/dZTAZ/yWYes3
         +0DZved861nvjkLPoy9+d75D+aHzn4DQg2RtPXSe/FGgzSW3Xdyc7qgEEhaynMoI0pGR
         RcYEaoHNF2xA863CGJxs+KD50DxAFzfZgRovpMdvGWHL/w14KeQSz2E2KnUt+DAjhjB9
         Ccq2J/ZR/qq3EKaXIVLe7rUYoagok8bxJaolz3gszn38PTbByOU/fwyiF7VlNSUcAD/A
         1GhA==
X-Gm-Message-State: APjAAAUzqgN8qVpoov4gOGCeSNO3k4Z5s2xBWqtb9WcEenjbHcG6d8Ak
        bGOMW5Q211kNsF2xhjvyjk3a89QLTbM=
X-Google-Smtp-Source: APXvYqwtIiM2jQQRDwVLMDAvkIOLbhorGtgsQRqJtncX40+Y0g09W50Mmph5+k2/rKckttxro5j/tA==
X-Received: by 2002:a17:902:ca:: with SMTP id a68mr20639505pla.204.1566197828124;
        Sun, 18 Aug 2019 23:57:08 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a23sm14891521pfo.80.2019.08.18.23.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 23:57:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:27:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Douglas Raillard <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, agross@kernel.org
Subject: Re: [PATCH 1/2] cpufreq: drivers: Enable frequency invariance in
 qcom-cpufreq-hw
Message-ID: <20190819065705.qhcb4ohtsekik3q2@vireshk-i7>
References: <20190808131857.21082-1-douglas.raillard@arm.com>
 <20190808173230.53ddupihjlr6uvne@queper01-lin>
 <14762a81-a81d-d05f-b42a-495dacb28168@arm.com>
 <20190809103704.fatayhzso2b62fmx@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809103704.fatayhzso2b62fmx@queper01-lin>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-08-19, 11:37, Quentin Perret wrote:
> Actually, one nit, the $subject should probably be formatted as:
> 
>   cpufreq: qcom-hw: invoke frequency-invariance setter function
> 
> for consistency with other patches in this area.

Applied with these changes. Thanks.

-- 
viresh
