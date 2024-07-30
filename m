Return-Path: <linux-pm+bounces-11681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B519414CD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459D81F245FB
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C204FCA6B;
	Tue, 30 Jul 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsmlOYGM"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8079E1
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351043; cv=none; b=rBGkYmomD2gQsFh8VOsyLRpPDQSa9+aR8vKILdMquYmVbnWPe/pCzfS9Ye4dYYIN4ZqT0zrJ6Y7rUnPLLMsYQU+rikOGxBmdWVB+9Nh9idTiN5z/Gl9I80jjvv6v5jCV0kCYq6XNMoTlYb2mrV0Yn4+2Rum0CPRrn8h46HyANBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351043; c=relaxed/simple;
	bh=/su2BcnabZX/TrE7372ur3oD5FOsqtWjgkoiVieoIr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDU/q3NB7/1+gQ+WWwzWyrG8lFPbw1DSVgiFd1LEARhB5uecbCwIfhmG0syG4ZvBHlizcEvuSWRwHBW0ilkiogZKFXuGNxiwur65BbcTzRn0pnbX4kwfzxRPEOiaKJk+Du93Kn7tYpK5wHYNA/RFAim4gmUfjqAYeV0IFsCfiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsmlOYGM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722351041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVLJRQHMlCsfQmzGTIuyPKFprVeRYU/US7OJwd+v6WY=;
	b=bsmlOYGMKZS7/7LqIo5Lb39RLpXLOmDxflwe3U0gtoq5j/v6+R8CmdB1wkQUAI1Y+4oGr0
	idczQ3yhddh/T5aiv8gm/qOXkxupslGRuMkMiVQwEy1CdZAgRj8Geu0HHPd4/dbXblRwyc
	oTofsWKlcYqd5bBvK0Fr2fd4TqkhTEA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-SgyaDlqZMdCfD5dwjWq_HQ-1; Tue,
 30 Jul 2024 10:50:36 -0400
X-MC-Unique: SgyaDlqZMdCfD5dwjWq_HQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2D001955D52;
	Tue, 30 Jul 2024 14:50:28 +0000 (UTC)
Received: from [10.2.16.107] (unknown [10.2.16.107])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68B6C19560AA;
	Tue, 30 Jul 2024 14:50:19 +0000 (UTC)
Message-ID: <5ecb4ac2-6204-4c20-b98d-9a0e1b33c5f0@redhat.com>
Date: Tue, 30 Jul 2024 10:50:16 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] locking/ww_mutex/test: add MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Karol Herbst
 <karolherbst@gmail.com>, Pekka Paalanen <ppaalanen@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
 Joel Stanley <joel@jms.id.au>, Alistar Popple <alistair@popple.id.au>,
 Eddie James <eajames@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsi@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org
References: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
 <20240730-module_description_orphans-v1-5-7094088076c8@quicinc.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240730-module_description_orphans-v1-5-7094088076c8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 7/30/24 10:43, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   kernel/locking/test-ww_mutex.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 78719e1ef1b1..10a5736a21c2 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -697,3 +697,4 @@ module_exit(test_ww_mutex_exit);
>   
>   MODULE_LICENSE("GPL");
>   MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("API test facility for ww_mutexes");
Acked-by: Waiman Long <longman@redhat.com>


