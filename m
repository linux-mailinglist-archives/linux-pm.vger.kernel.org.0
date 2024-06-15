Return-Path: <linux-pm+bounces-9228-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C12C9098A2
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD1F281EEA
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 14:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A049624;
	Sat, 15 Jun 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MX4ei3uI"
X-Original-To: linux-pm@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69051E511;
	Sat, 15 Jun 2024 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718461646; cv=none; b=q3VmaNo+KbIg7aY99Ymw51D6bZjrYMQN/q10ooLGjGr+2NJKP0cQvmIOPc3GchlulFgeYIM+FT3bcszTZRRWHuDs/OXc2B0aTh6MxUg6vEbfVqSNhvQU/XuBfIWIBwqRuzguTcUOcqwQtMmPe9SOLEClRd+yTeg+U1tUZLtUbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718461646; c=relaxed/simple;
	bh=o/SQd+brB2QkhekD2Nrpw7e1Fn3IUdRHYI44H3HScPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSVZPOKaC31DOEnrvHMMWoMnrFqgyqs1hyCEvAvaFsd3heT29vtj3WVJF3qy53o2hR9juUcNBxnGIWhGbCS3Ifk5ImVuHtI7GAdgxCoehSN2/F+w3ikCAcPWcxHtv4pU/cC07E6C4f6yhCfEf1rxyndOKk8uYyTtU3oWVPookkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MX4ei3uI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WMV4XdfigA9k42kYaaxbDI3Cm/CZfKkOSa4d9FAnLBU=; b=MX4ei3uInKB1tI7JcTqP72OeAy
	dAOfULdNDyKssbwffE64lKqDt1qPcRwnmYki7uISHpalFK3Sjz+iistgd0XgbiGLtzs89mevgmISM
	ImrsPYaQpLvEw5Phh/i3yvlf7inlN3S0pzbU9GojESRqQ8uAeFXUZJUkow9Fm+H/1X8oBu/mLnmRq
	9KaqOzmhz1xLB1XksP4LJz8QjpGXNQ/awK+/Fm/9fA5aTCEzGfHyVwaUPxr/l/qe+aq/QXFM3w+YG
	EVkOwrIShH1qhBOmLK+G7AsdGnZ871aaaCCVzH2vqnFOpwV4pDOcfLcGzWTk+QUOVhhlilPvTeTZk
	szS/VgLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40990)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sIUMt-0003Oz-1J;
	Sat, 15 Jun 2024 15:26:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sIUMc-00039D-Bw; Sat, 15 Jun 2024 15:26:42 +0100
Date: Sat, 15 Jun 2024 15:26:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Guo Ren <guoren@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Xin Li <xin3.li@intel.com>, Kees Cook <keescook@chromium.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tony Battersby <tonyb@cybernetics.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Brian Gerst <brgerst@gmail.com>, Leonardo Bras <leobras@redhat.com>,
	Imran Khan <imran.f.khan@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	David Vernet <void@manifault.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-pm@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v2 00/14] Introducing TIF_NOTIFY_IPI flag
Message-ID: <Zm2kouKx/NSSrr6x@shell.armlinux.org.uk>
References: <20240613181613.4329-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181613.4329-1-kprateek.nayak@amd.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 13, 2024 at 06:15:59PM +0000, K Prateek Nayak wrote:
> o Dropping the ARM results since I never got my hands on the ARM64
>   system I used in my last testing. If I do manage to get my hands on it
>   again, I'll rerun the experiments and share the results on the thread.
>   To test the case where TIF_NOTIFY_IPI is not enabled for a particular
>   architecture, I applied the series only until Patch 3 and tested the
>   same on my x86 machine with a WARN_ON_ONCE() in do_idle() to check if
>   tif_notify_ipi() ever return true and then repeated the same with
>   Patch 4 applied.

Confused. ARM (32-bit) or ARM64? You patch 32-bit ARM, but you don't
touch 64-bit Arm. "ARM" on its own in the context above to me suggests
32-bit, since you refer to ARM64 later.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

