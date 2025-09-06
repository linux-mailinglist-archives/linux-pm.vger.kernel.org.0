Return-Path: <linux-pm+bounces-34049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F0B46C2C
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2587C625C
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3252248AF;
	Sat,  6 Sep 2025 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kfjdZ+e3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28940BA4A;
	Sat,  6 Sep 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757160109; cv=none; b=DikMr3N8ta6WVDeyD1iETD/7YkbTsgbiaUvpysmP6qfnCQpB3gzcbX9D9eH2+gC0rL6xrVQNlPUEpQVcJrplvmAGFnOyFtu+idHLx7JZ/AR4jyjoZOskCiKI2TWnT5vY6S6UD9uyRmXR0fP27G05XXftoB3021PcngBY+dMSwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757160109; c=relaxed/simple;
	bh=4vRYrjH6J57tMx0VKrL3uOfNTnqiUf0AD8pUHQvVjV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiLX/tMZEDvpBb6cOBhHIW8lQ+KCs60aRkWcxoKiq7e/g1jKTY8e6ujrJH12nkW/GDHIhQqxWiKF3u8TDFW/KN6NMi7uSvmHE0v3eRuBFI3R+kG/C7RbKUAb7N6ITiNVOrPQUjeNe2MqMEXOeYbtNoT5Xra8fTziKvXEItBI0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfjdZ+e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA7C4CEE7;
	Sat,  6 Sep 2025 12:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757160108;
	bh=4vRYrjH6J57tMx0VKrL3uOfNTnqiUf0AD8pUHQvVjV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfjdZ+e3739FJLKfOOOLw+URQPmA7443jKMeYPYXmWE+iXqMs27s3yyLU/PW+eYdL
	 vE5OaWYNTS2olHvV+EvPErpBgI/XwzLhClCYiP+nlyhB1N4YOLNHandKco3xB9aaY0
	 1jzlQwK1SaSk8XCk9tTgWtMNk17aXBHroMzeZ5TE=
Date: Sat, 6 Sep 2025 14:01:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v1 0/2] PM: core: Updates related to device link lists
Message-ID: <2025090641-reveal-swab-6e2b@gregkh>
References: <6202205.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6202205.lOV4Wx5bFT@rafael.j.wysocki>

On Tue, Sep 02, 2025 at 03:40:54PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> The changes in this series clean up the usage of _rcu list walks for
> walking lists of a device's links to suppliers and consumers.
> 
> The first patch changes the _rcu annotation of those list walks to
> the _srcu one which is more appropriate because SRCU is used for
> device link lists protection.
> 
> The second patch (which is not expected to make any functional difference)
> adds two macros for walking lists of a device's links to suppliers and
> consumers and updates power management code walking those lists to use
> the new macros for more clarity and protection against possible coding
> mistakes.
> 
> Thanks!
> 
> 
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

