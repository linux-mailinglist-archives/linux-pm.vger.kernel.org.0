Return-Path: <linux-pm+bounces-19469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6F9F711C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2024 00:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4799A1884980
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 23:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C11FD7B5;
	Wed, 18 Dec 2024 23:45:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510D71FD797;
	Wed, 18 Dec 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565545; cv=none; b=pXHV6+cGJ1uQXi60VXIrSrVm46s9GywKSh2ttsPTaEJoixc7EWX1AgcIDAJLz53W407Kq/dIn4XGtEHGff9PydmD5+4QETDSEf/xVsU3p5v2eDH641I+17Cdc6qwAsrCcDaYT7AdK5pMvyQJeD64VtM4IwE6yfe7Mp8nGtS/qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565545; c=relaxed/simple;
	bh=31OncVWgw3S9MDtK0acw9Uvv9YdWo3BxabV9JAh3HRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S7YmKOevpbK7CAGCHhqeLSTAxEXmMl3AKpqykRpd3DzMnwX8AvOqJJLsLJDHnilVHdV5hSBbj+Zl6WFMr7GQivShZfUazu9VQq/aCXHUwN0yMCLwV5UV+61hIOcePYUi6WPkBRTgAjvglnPqUK5h8H0XFJJElJXFdgx2acdp0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1085C4CED4;
	Wed, 18 Dec 2024 23:45:44 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 1EB6E1060345; Thu, 19 Dec 2024 00:45:42 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Davis <afd@ti.com>
In-Reply-To: <20241117053443.1148902-1-iwamatsu@nigauri.org>
References: <20241117053443.1148902-1-iwamatsu@nigauri.org>
Subject: Re: [PATCH v2] power: reset: as3722-poweroff: Remove unnecessary
 return in as3722_poweroff_probe
Message-Id: <173456554208.3125554.16126631564482305989.b4-ty@collabora.com>
Date: Thu, 19 Dec 2024 00:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 17 Nov 2024 14:34:43 +0900, Nobuhiro Iwamatsu wrote:
> The return is executed on the devm_register_sys_off_handler() line in
> as3722_poweroff_probe, so the last return line is unnecessary. Remove it.
> 
> 

Applied, thanks!

[1/1] power: reset: as3722-poweroff: Remove unnecessary return in as3722_poweroff_probe
      commit: 156fb706f915ceb436200030e3730305bbf12f6c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


