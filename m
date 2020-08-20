Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C651824C62A
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 21:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgHTTIQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 15:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgHTTIQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 15:08:16 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0DCC061385
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 12:08:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c4so2333394otf.12
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rJkNX7aISJQF1HEbitGv96cf5H9J8RA9/hnvYbjYcU=;
        b=SVAu5PHuUOGqtXGceXLP9WpbIL/cxA55JdAn5X/D371uFWUWWGoo/iguEfLd68FJ6B
         M2oDYb0jIvcRrSNYHmNwrGQnQaIMtHrzenA9cin3ErHOWXgeN+oP2cf+/ieNOZ7nbVm9
         hPvkvRqGCVki4ZEmZQvkM1O0n60u5sJCKNvsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rJkNX7aISJQF1HEbitGv96cf5H9J8RA9/hnvYbjYcU=;
        b=blPy20B0vf//yB8sfYCS+Wv0RME8ILpLdgfX2ohKPCELTuO8nAXgVTGOCI6proL3MX
         oDi1QmU1p1rmpqwrJaDgovcUDVjkoUP+JdAPPU1A5ZMnkiPeRrAcQeh68g7c2wIgs2pI
         qHuon+wSyAiH89RzZpmVFdnNsz5jaw6Pe4c0MkOln6ooKF9dFYQ5+i7WIK7zn32JSsDW
         LAS3yx/lerl1h85f3KmsC+SnoJl45dPqlJA0oijUxBB1fti9pMaBujsNbWu5tnKKHNY/
         4fJuvzh0YEzgpybjic+ygRaP03jOoG89T4I5oGKdz+6qNpM63TPjOKwDY03rr65inIB4
         Ctbg==
X-Gm-Message-State: AOAM5327Rs6+cTZg82F7BirO3RKe+CkxFtouNScfPPpd5hadoH3PQ46c
        re8546LvaZN7M3rgAo6mvXzWU8survmUpA==
X-Google-Smtp-Source: ABdhPJx8D2/BIEim2e7y0tbflfDpnXCdS79ZXOKTv04cVKoDxPIMaCGaiirtIAKlkQjpYGa5bze5kA==
X-Received: by 2002:a05:6830:18c1:: with SMTP id v1mr65495ote.159.1597950494029;
        Thu, 20 Aug 2020 12:08:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z63sm641352otb.19.2020.08.20.12.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 12:08:13 -0700 (PDT)
Subject: Re: [PATCH] cpupower: speed up generating git version string
To:     Thomas Renninger <trenn@suse.com>, shuah@kernel.org,
        Martin Kaistra <martin.kaistra@linutronix.de>
Cc:     linux-pm@vger.kernel.org, skhan@linuxfoundation.org
References: <20200812094912.2648-1-martin.kaistra@linutronix.de>
 <1698400.ZyLY7WPuaR@c100>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3db4397e-47f7-d38c-fbba-cd647f5cf92d@linuxfoundation.org>
Date:   Thu, 20 Aug 2020 13:08:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1698400.ZyLY7WPuaR@c100>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/20/20 4:27 AM, Thomas Renninger wrote:
> Am Mittwoch, 12. August 2020, 11:49:12 CEST schrieb Martin Kaistra:
>> The variable VERSION is expanded for every use of CFLAGS. This causes
>> "git describe" to get called multiple times on the kernel tree, which
>> can be quite slow.
>>
>> The git revision does not change during build, so we can use simple
>> variable expansion to set VERSION.
> 
> Good catch,  thanks!
> 
> Acked-by: Thomas Renninger <trenn@suse.de>
> 
> 

Thanks. Applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower 
branch for my next pull request to Rafael.

thanks,
-- Shuah
