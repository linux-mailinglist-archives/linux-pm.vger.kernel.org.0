Return-Path: <linux-pm+bounces-41533-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGaMNqzFeGmltAEAu9opvQ
	(envelope-from <linux-pm+bounces-41533-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:03:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6E954C9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FA863068224
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45DD35B628;
	Tue, 27 Jan 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPloJ4a9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C035A952
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521899; cv=none; b=Aq10pAq4l0bNcDcba1Z/Iq+5JfTDJoc05v97XMA2hqslKaB5k/tLV90wjXILe/CwxRBn3S7SZCCrMPS6UOuSyTa9HdTiWJu+5Ltokv+qjfOBu62ztvGsHa2eOa3QxoOw8MPvbmtIXHP+z3XsHtDUR/n3Hfr/BdVXNxTkXWzLe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521899; c=relaxed/simple;
	bh=hwfc/oIo84aWP8R0PtVaMfwzN5tLI+FqZOEiWg9miXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeaY3nBO8O6SmXgtYVU+dmaUd6v7RIoPiCx+4neMvw7xJvYpLLXWuQquaUrQWm8lIRZjqn6fDJXvEYt1TmxnJuDw2PlfpH/VAug2j092fZ4S9tf/0dwFvYb266AkPMqfBggvaT0aR8HIMb+Iwbae5LYQN/eVBTeS2okm9RBp+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPloJ4a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359DCC116C6
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769521899;
	bh=hwfc/oIo84aWP8R0PtVaMfwzN5tLI+FqZOEiWg9miXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YPloJ4a9gxX3EcufNsa/ECruKIzrBAXC0RZMD9pPWcFBMEyPOo5Z5uI3FNS5mx/ye
	 7kWCn59Bf9E74MFdhsOpOkY9ptIMcE7kBSns7+HDkYELbBV7BzzV03ezPSlRKMvgLd
	 MNJUFV9LfM5d9hcdlkq/Gqp0Mna1XYPeThmWlgYz2NcZQ6M1/cBQ1usLVxnmY2pJmO
	 +c6qWIRl7Bf3wmP+UxzR8WhVdiNLcZ005yVu5ykpxeB4k1Dwsz9rkUdMq9uYLpEQgQ
	 hXBYM9jmrC+vAV3quBfTjUrHidxj/lk8cfFxnhGwo++2yCTts+jJsvGsJ6Q/IPrGfR
	 XxJqCe7t17Iqw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c87d82bd2so3855133b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 05:51:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4m54KgTbu1qKrNuygydunAi4mJ3H/fPMO+XQcNBS60OYDOgFBe7mHyMg4LfJca0imJcblQZVuJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1IFl9quOm9Dxv/8ejQPxZEbfVb+oxWwGn1MshfGM841Pdogi0
	LKjCJBALFm9kYkFQfs0G77Lf6UTr0WWyE4CPBPs8iPdS0zNuz/j7P/wkm6Fcg/V6QuQHzytVsQA
	BTuMyAfOUzFL0tY2kHmRAg++PMHeJlvw=
X-Received: by 2002:a05:6820:80c9:b0:662:b8fe:20d with SMTP id
 006d021491bc7-662f203dda3mr1114050eaf.21.1769521898173; Tue, 27 Jan 2026
 05:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <k3brbzyfuqulewxmkyjolnxtkn7nnsduf7keqch5obgpcqyovl@jtopk3yoqlr5>
In-Reply-To: <k3brbzyfuqulewxmkyjolnxtkn7nnsduf7keqch5obgpcqyovl@jtopk3yoqlr5>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 14:51:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gwG6yFxYatkmeNuLRrnX5ee0FfSnx0j1zM5nrJ1So9iA@mail.gmail.com>
X-Gm-Features: AZwV_Qi94Ywu8ZkBrvnLgcSH-gXtdrpRG2LJgZHpavvLzMPwG-ncqcgv4aUxjV4
Message-ID: <CAJZ5v0gwG6yFxYatkmeNuLRrnX5ee0FfSnx0j1zM5nrJ1So9iA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm fixes for 6.19
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-41533-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3D6E954C9
X-Rspamd-Action: no action

Hi Viresh,

On Tue, Jan 27, 2026 at 6:57=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1=
e8:
>
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-fixes-6.19-rc8
>
> for you to fetch changes up to 7e3debb4c72fe840d60014192cf93950871fb3be:
>
>   cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list (2=
026-01-27 11:21:22 +0530)
>
> ----------------------------------------------------------------
> CPUFreq fixes for 6.19
>
> - Add sentinel to qcom_cpufreq_ipq806x_match_list (Pei Xiao).
>
> ----------------------------------------------------------------
> Pei Xiao (1):
>       cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_lis=
t
>
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> --

Pulled and added to linux-pm.git/fixes, thanks!

