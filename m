Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AA62F80F
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 09:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfE3HrQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 03:47:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38476 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3HrP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 03:47:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so3155289wmh.3;
        Thu, 30 May 2019 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VWZxqIM6YJjq4geM4D8XBcvh6oQTYQMH93V0r0IefE4=;
        b=dXuxDv5lfPx49gKTlUmwPG4nYYEqz9PjkHoZWPEZY43ybVrY0sa4rAP0D7eI3iJOAU
         TVnsq7ursXJBrXz4rUlVabsqsbdDLMBtwmHCTA34kwwU0e8fQUIuLfk7BieXUf6n7seL
         ai+iGIwW77t2EEUPKNUa8K2jbGNiIgPx+E388c6WPOmzcKP6P5jRtpmyilP/v1wI9LSz
         7q3PVt1pLUifpG4BoGdMBmnE/QJCJWzse3iNkDXkgCmOJRhXYdm0Bb20/PtaqEwAFtM1
         YK+75955JdDSQEdmGrAM9uxYasz/TL9WR4Apm77wNyBGX0FemZL0QdKX2W82gWoJlw+r
         6X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VWZxqIM6YJjq4geM4D8XBcvh6oQTYQMH93V0r0IefE4=;
        b=kN+t7Oj7E5XbawARTz6ArgK06GVKV7UemjrMXR3Rf1j7CHE+Uo4dMP2mSQBTAoPXl4
         2mHpAuSmZpNhFGQ0x3+0dW0OUBS0hna3Bh8L91F6x8enRy+tUDkt/Lqx4co4mhMSvSyM
         NlKIqnubn0oSYl+YQKN/VwLrVN1IpZ6H4syrOa5k9Y/aKVXzW7e5eRPg2wsKutfE/M/M
         q3h+dZ7dKt6BpgrQFKHnHHYTk+Hjd82NPNqQS9mpKZkOhWU5dLdre+vewHH0i0SYLKRo
         o1+hhX5HEpJfx+mMRp0g3mcPRpQF0SPXCRui/rh1GJEOehtQ/TsBMJRJPogQHgCwdYDt
         mpgQ==
X-Gm-Message-State: APjAAAWdhkUa/yI/kSBvY5Mr6aVda+gjOf3eRU5JC6TFKhmrJqYpWSf9
        w24iA6FI7ZqyLX+QM39txUI=
X-Google-Smtp-Source: APXvYqyT9s47ZWFjibXPxSHF9pqMH9zinhcoZjXf/xLXKG5me1ok0iQyHkkryeozUYR16FXweTpdCw==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr1313874wma.118.1559202433979;
        Thu, 30 May 2019 00:47:13 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u19sm5575133wmu.41.2019.05.30.00.47.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 00:47:13 -0700 (PDT)
Date:   Thu, 30 May 2019 09:47:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86 <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
        Ido Schimmel <idosch@idosch.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] x86: intel_epb: Do not build when CONFIG_PM is unset
Message-ID: <20190530074710.GA68696@gmail.com>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1627338.1fd8ofggM8@kreacher>
 <20190509174338.GA24432@splinter>
 <3844875.YPkTDDlcrF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3844875.YPkTDDlcrF@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 9ed0985332a6 ("x86: intel_epb: Take CONFIG_PM into account")
> prevented the majority of the Performance and Energy Bias Hint (EPB)
> handling code from being built when CONFIG_PM is unset to fix a
> regression introduced by commit b9c273babce7 ("PM / arch: x86:
> MSR_IA32_ENERGY_PERF_BIAS sysfs interface").
> 
> In hindsight, however, it would be better to skip all of the EPB
> handling code for CONFIG_PM unset as there really is no reason for
> it to be there in that case.  Namely, if the EPB is not touched
> by the kernel at all with CONFIG_PM unset, there is no need to
> worry about modifying the EPB inadvertently on CPU online and since
> the system will not suspend or hibernate then, there is no need to
> worry about possible modifications of the EPB by the platform
> firmware during system-wide PM transitions.
> 
> For this reason, revert the changes made by commit 9ed0985332a6
> and only allow intel_epb.o to be built when CONFIG_PM is set.
> 
> Note that this changes the behavior of the kernels built with
> CONFIG_PM unset as they will not modify the EPB on boot if it is
> zero initially any more, so it is not a fix strictly speaking, but
> users building their kernels with CONFIG_PM unset really should not
> expect them to take energy efficiency into account.  Moreover, if
> CONFIG_PM is unset for performance reasons, leaving EPB as set
> initially by the platform firmware will actually be consistent
> with the user's expectations.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is complementary to the EPB handling changes made in the current
> development cycle, so IMO it would be good to do it in this cycle too
> if there are no technical concerns or objections regarding it.

Sure:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
