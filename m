Return-Path: <linux-pm+bounces-34730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE05B597D5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6AE1C00051
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491A30DEAA;
	Tue, 16 Sep 2025 13:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zSdubmII"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF62C3272;
	Tue, 16 Sep 2025 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029875; cv=none; b=UF9BPxkGcwrMQZiTdNIJFlv6LFR6Q0ir37SJjjBhEVFiObwxtAnvRwmM9GWkWncYBh+QUSmJoByRQ0sxtCZ4O+aC5LW5mMtOuuDxPXswIJoPgsL3iAWPTYNymTJsJEsAFzOuAEbLosHowg7MDL73/c8CYwWgxwysj8Rweak4rzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029875; c=relaxed/simple;
	bh=JhruMMkhxbf2sV8h74+GEbHn8WmMzYkUeIJ+xJcevMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljhXVqtVKHgbpig+XJWyTqbe3B65WIhjhPzsDv8Qx7G9qqyLeUGCzFwKs9BwZctQNKqWdt7vbbNZtJ+k6ktGt+dQDQQtgdb7GGBWn6G5IwzaKWjV35Gzp2kQ1Dhg3eIIX0MypEpWwRm5YYVtJJCV1o6s9jeJgTuCEmLTTHISbjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zSdubmII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFEFC4CEEB;
	Tue, 16 Sep 2025 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758029873;
	bh=JhruMMkhxbf2sV8h74+GEbHn8WmMzYkUeIJ+xJcevMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zSdubmIIKTWNFvRPTJskcD/bR7Fu0oR09boW7zcv1TUvcjCEb5N2QEi7hl2644m1R
	 r/md4onY9YR7+mzEmpM6KB3fx3yY6rAprnjDJRtgT93r9Hc9Td4WgsKzBwxreLNnAq
	 BVFjH33d1XBUemurkGLb1NLwyOHNim40ZS0GIaJQ=
Date: Tue, 16 Sep 2025 09:37:50 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Sebastian Reichel <sre@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, David Collins <david.collins@oss.qualcomm.com>, 
	=?utf-8?Q?Gy=C3=B6rgy?= Kurucz <me@kuruczgy.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
Message-ID: <20250916-almond-pelican-from-vega-a8d01d@lemur>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-3-6f6464a41afe@oss.qualcomm.com>
 <gk2ho7ugp35kb4x65meqsm3aufnry6srr4p7jspf6xyn7ywzkh@vd5ca7txjdk6>
 <0cf4b0fd-e468-4aab-9ec2-38da93435557@oss.qualcomm.com>
 <5736df73-c90e-4f11-b461-c38da4e811e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5736df73-c90e-4f11-b461-c38da4e811e1@oss.qualcomm.com>

On Tue, Sep 16, 2025 at 09:59:04AM +0200, Konrad Dybcio wrote:
> + Konstantin
> 
> It's quite common to see someone leaving a T-b on the cover letter,
> trying to say "I gave this series a spin" and then seeing the tag
> appear on unrelated commits within the series (e.g. bindings or some
> cosmetic fixes". Maybe some sort of an interactive (opt-in is fine)
> dialog for "which patches to apply t-b/tags to" could be worth the
> effort?

The plan is to add interactive mode to a few commands, including to the
trailers command. This will open an interface similar to interactive rebase,
where you can mark trailers as accept, skip, or ignore. That should do what
you're asking for, I believe.

Best regards,
-K


