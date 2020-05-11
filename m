Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828601CD49B
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 11:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgEKJMu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 05:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgEKJMu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 05:12:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF24EC061A0E
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 02:12:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so9949348wrt.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2020 02:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XQ+jP1nnCzNmRgk4F+3KfRo8E6ew3xugv14WTX3xrhk=;
        b=Fm8+Q/rCElaq3BLoRIbF3S9bCVcrGdOm3rPI51n/OU1oCeN8q+stJOSantTvxh0XOY
         2ffWhNM8aHIKi2E5n13RjB9GnvRGTBmBhwH2LnEadzSU430Lml4Cyag+MsUTQBdBOtz+
         VLiFLtK6uryhGD2KkPGlNdeTAkQPL7xP73YEbCi4PEy/9Q4aG/s9vijC3hP8zzWz787r
         KgsJS9HEt/eD4iPoQ8GpOUrp2igAdLAOXTc1lWe6YkzadPrsil8S7hhL4blrUNJ3DL4C
         VTDRxxhDXOm92IvZfXx4b7u31JOSfY8tkXxGp/D8iSggF3/GcH2k1SsidgLIhwUg0I+w
         Z/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XQ+jP1nnCzNmRgk4F+3KfRo8E6ew3xugv14WTX3xrhk=;
        b=UwcdMl6d3rhzd5FnW1HP7jkfQQAEz0XacRCpl78jYTupx040zb7PrFt4W09o3uJVSU
         Mn1HawaceSN3FCYcxKwcyUsV7WQljMORvzi+y3yYT6FY4jk8S5JtDxErF19ETVKyUOhU
         o4NFJUrmVq9TdIBOsvrSH7xY7+o4G7nAg/VL1JxvkX3iivVSFV8WUHPFIISpYdX6DpJ3
         RRo+XLBc8yjSZWI4APG0J6Ub1Sl8nQWByXxl6DIFkzv5MqgjRXkAfshEvm7Qi4DyJnfb
         tJ3Ru0Q2DzfkCf+TIY0+XHugWZU1HE/Cd0AW+xkPJWrQkxmbsV9tsONzG88HhrGEWn2k
         7SwQ==
X-Gm-Message-State: AGi0PuYSaQQ3L517qkMU3LkIknUlholfrgpL+yvMtDBr5FZiecv2aX2G
        eMjAOKfUZyU28RfuKYrIOgLWfyFyjsE=
X-Google-Smtp-Source: APiQypJkQszfVt9LmkmPmAW4ZwUnumovrA3iOpsWmo0yzVR9npMGeno/vkDpgIRNqChqhH40S4dRQg==
X-Received: by 2002:adf:aacb:: with SMTP id i11mr17940151wrc.6.1589188368141;
        Mon, 11 May 2020 02:12:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id t71sm27159533wmt.31.2020.05.11.02.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 02:12:47 -0700 (PDT)
Date:   Mon, 11 May 2020 10:12:44 +0100
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, sudeep.holla@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        fweisbec@gmail.com, tkjos@google.com, kernel-team@android.com
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200511091244.GB229633@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com>
 <20200508140938.GA3344@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508140938.GA3344@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Peter,

On Friday 08 May 2020 at 16:09:38 (+0200), Peter Zijlstra wrote:
> Do note that (afaik) ARM64 (and Power and probably others) has modules
> in an address space that is not reachable from regular kernel text and
> needs those intermediate trampolines.

Right, but I meant this series in its current form doesn't actively make
things worse for existing users. That is, the act of modularizing
schedutil has no impact on those who compile it in (because I agree that
would be a solid reason for refusing that series), and they are still
perfectly free to do so.

The 'new' users who deliberately decide to compile it as a module will
have to pay that price, but that is their choice. And in the Android
case, as you've understood, this is a price we are ready to pay.

Thanks,
Quentin
