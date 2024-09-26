Return-Path: <linux-pm+bounces-14769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B44C986BE3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 07:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC2C1C2122E
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 05:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6974120B;
	Thu, 26 Sep 2024 04:59:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5FBE6C;
	Thu, 26 Sep 2024 04:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727326798; cv=none; b=M/g/uNQYasdaUJkUC9LeEOFb+znNE6NtbEd8arxyz4LRRJ0k0LiORTK/aMiOXtdbes+65oWKCeWAtWWzmBL0xU+oOqDJAmSSEoNmMcRGZrv0B1q+fOyXeI4pa9hO8G2HcrblhyBQdY7J+SAsum1VPd03zaeHlFwcCjSRIfZpQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727326798; c=relaxed/simple;
	bh=2XIXGD2Rn6RQu8hB0JdURTj3F2UEZ6CeicHcLbUObOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VnuptMe5zOn4qRcmCUc9tNYqeH9WQeuKjJEZ7FsooBjLmlC2QjUoT4VJqFLbrb6c1grrsj9b86/2bvGW5ojcHSvqtfWP+SdNPux7b/FMSzbWByWbtdBayIxudVRRwWXGR8+ZRkSSFpmh0bGUqr/XXzWZXVJu8d8IH+F4+2k/L84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B71FC4CEC5;
	Thu, 26 Sep 2024 04:59:55 +0000 (UTC)
Date: Thu, 26 Sep 2024 00:59:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net,
 skhan@linuxfoundation.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] trace doc: document the device_pm_callback events
Message-ID: <20240926005952.5ba2fda4@rorschach.local.home>
In-Reply-To: <20240922132636.34413-1-0xff07@gmail.com>
References: <20240922132636.34413-1-0xff07@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


This needs an ack from one of the power management maintainers.

-- Steve


On Sun, 22 Sep 2024 21:26:28 +0800
"Yo-Jung (Leo) Lin" <0xff07@gmail.com> wrote:

> Add documentation for the device_pm_callback_{start, end} events
> under the "Subsystem Trace Points: power" section.
> 
> Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
> ---
>  Documentation/trace/events-power.rst | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
> index f45bf11fa88d..7031954f7ed3 100644
> --- a/Documentation/trace/events-power.rst
> +++ b/Documentation/trace/events-power.rst
> @@ -102,3 +102,30 @@ And, there are events used for CPU latency QoS add/update/remove request.
>    pm_qos_remove_request     "value=%d"
>  
>  The parameter is the value to be added/updated/removed.
> +
> +5. Device PM callback events
> +============================
> +The device PM callback events are placed right before and after an invocation of
> +a device PM callback during a system-wide suspend/resume attempt.
> +::
> +
> +  device_pm_callback_start     "%s %s, parent: %s, %s[%s]"
> +  device_pm_callback_end       "%s %s, err=%d"
> +
> +The first two parameters in both events are the same. They are:
> +
> +  - The name of the driver.
> +  - The device whose PM callbacks get called.
> +
> +For device_pm_callback_start, the rest of the parameters are:
> +
> +  - The parent device of the device (if any).
> +  - Level in the power management hierarchy the callback belongs to (e.g. power
> +    domain, type, class, bus, driver). Some stages (e.g. early, late, noirq)
> +    will also be explicitly mentioned in this string.
> +  - The ongoing PM event. You may find definitions of those events in the
> +    PM_EVENT_* macros in include/linux/pm.h
> +
> +For device_pm_callback_end, the only remaining parameter is:
> +
> +  - The return value of the PM callback.


