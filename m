Return-Path: <linux-pm+bounces-42524-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIJbDR/jjGkeuwAAu9opvQ
	(envelope-from <linux-pm+bounces-42524-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:14:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEAF127562
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 21:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64C1B301477B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 20:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBCF3542EA;
	Wed, 11 Feb 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjXTl78D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670F8340294
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840859; cv=none; b=U87J780nYM8vnHMRT0CwPvyS8fbl8UsaQ3FZGT6Ylx05oyv3JITBrKvmbVGPQf1LH45P+vwx4TA1tLYqBQCBRHDzVDnRQ9RegfdhKMBYk8ZhhSDwv7QUWZtgsOyso7G5NC0twS7gN27jAwTX8pOs85vPTfWzNuk8ICNREZAH8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840859; c=relaxed/simple;
	bh=4oE5bxzzIgZIg7pMmnyBrE68Ssxtm2bqNK187nEPBz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkhlNdO1o5nvS9txWdF0/rYmG2noE+S6ZUeMdJCzyBlUIea5L1pYUrTo1K3xTywX1VKcvXhkqM4hZk0hIXV1Rq1pFkVUSgpf3WLHhef8VCgk2rHXePQuSXr2RhCwjca6G0RJZ6pVU23470Xs9BwNf+Vwd2bU4t0bXorkl6r4azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjXTl78D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE4DC4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 20:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770840859;
	bh=4oE5bxzzIgZIg7pMmnyBrE68Ssxtm2bqNK187nEPBz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cjXTl78DQyW+fhZ6UHoRB6P8/hEx18A/o4Pfe2YJpIFiHkaIxwO6TELb6OIOJvcZx
	 8EnV0C0W3XVQq5drpYeDlcsKT/3q2GfVV5U4sIDu+WgPDlEWaqzTkqohjqdnt2SNhD
	 Dcm/YLX/j7hqn+pDLX5GYynV8vropzbQCN+FpJy8zQEOmq+QKclrQDhFl0OyQwbaV2
	 4kl9cy7KprInPHhyI45fORG2F2fFiz0Wqew3nVJYV9vCHrOrjbyS/mvcqOGTnKQUk8
	 myyEk6VmfrO0H2ocNdDYywSWn9XEYbYITTR0aAZ3I0glOIc3Gz7WSa8W74Va64zGQB
	 bnYUG1p86yCQA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-673ee2a98b1so912479eaf.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 12:14:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHvIygM7IXlUAjcm+18vy2q0cNEz+dJQHYt3Eyvq9YM5pcRzTvxt7GZCsxr1lp3oEma4djk5UtWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfrBA/+4yewpJLgIknh4j86Cs1aCdNpO030r28AjhJ5xtgAlU
	h4vOCDUvbK9LBQHULQX3pEFX4OFusgPcsVIeAamJTRIwDkOdvTY5j2MObvIEHlABtIG8lw5g2x+
	MYQNWobCqPFi6SdN9dmklozWXxb4+SBg=
X-Received: by 2002:a05:6820:1786:b0:662:f39e:efb8 with SMTP id
 006d021491bc7-6759be8a097mr213053eaf.80.1770840858194; Wed, 11 Feb 2026
 12:14:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206092317.148885-1-akaieurus@gmail.com>
In-Reply-To: <20260206092317.148885-1-akaieurus@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Feb 2026 21:14:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjViMyma4X6sWszq4euQ3=R2fE3gvzqJFDshbrnF9tGQ@mail.gmail.com>
X-Gm-Features: AZwV_QjBb-u_jUdNKVPQ1QJhSPAFAR34xH-XiKGRSRFXM4smqY1aMaWFR9RS7fE
Message-ID: <CAJZ5v0gjViMyma4X6sWszq4euQ3=R2fE3gvzqJFDshbrnF9tGQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: wakeirq: Update outdated documentation comments
To: Wang Jiayue <akaieurus@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gui-Dong Han <hanguidong02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42524-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ACEAF127562
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 10:23=E2=80=AFAM Wang Jiayue <akaieurus@gmail.com> w=
rote:
>
> The comments claiming that dev_pm_*wake_irq*() helpers must be called
> with dev->power.lock held and only from rpm_suspend/resume paths are no
> longer correct, since pm_runtime_force_suspend/resume() call them
> lockless. Update the comments to reflect it.
>
> Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
> Closes: https://lore.kernel.org/all/CAJZ5v0jN9fU9NdWqc-+F5hiSEP4JkR=3D_qc=
dGzzHtk1i5tvCDbQ@mail.gmail.com/
> Fixes: c46a0d5ae4f9 ("PM: runtime: Extend support for wakeirq for force_s=
uspend|resume")
> Signed-off-by: Wang Jiayue <akaieurus@gmail.com>
> ---
> v2:
> * Rephrase the comments to also cover the
>   pm_runtime_force_suspend/resume() case, as suggested by Rafael J. Wysoc=
ki
> v1:
> * Initial fix just remove outdated comments
> ---
>  drivers/base/power/wakeirq.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index 8aa28c08b289..f5db37c4818e 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -270,8 +270,10 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reve=
rse);
>   * otherwise try to disable already disabled wakeirq. The wake-up interr=
upt
>   * starts disabled with IRQ_NOAUTOEN set.
>   *
> - * Should be only called from rpm_suspend() and rpm_resume() path.
> - * Caller must hold &dev->power.lock to change wirq->status
> + * Should be called from rpm_suspend(), rpm_resume(),
> + * pm_runtime_force_suspend() or pm_runtime_force_resume().
> + * Caller must hold &dev->power.lock or disable runtime PM to change
> + * wirq->status.
>   */
>  void dev_pm_enable_wake_irq_check(struct device *dev,
>                                   bool can_change_status)
> @@ -303,7 +305,8 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
>   * @cond_disable: if set, also check WAKE_IRQ_DEDICATED_REVERSE
>   *
>   * Disables wake-up interrupt conditionally based on status.
> - * Should be only called from rpm_suspend() and rpm_resume() path.
> + * Should be called from rpm_suspend(), rpm_resume(),
> + * pm_runtime_force_suspend() or pm_runtime_force_resume().
>   */
>  void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable=
)
>  {
> @@ -329,7 +332,7 @@ void dev_pm_disable_wake_irq_check(struct device *dev=
, bool cond_disable)
>   * enable wake IRQ after running ->runtime_suspend() which depends on
>   * WAKE_IRQ_DEDICATED_REVERSE.
>   *
> - * Should be only called from rpm_suspend() path.
> + * Should be called from rpm_suspend() or pm_runtime_force_suspend().
>   */
>  void dev_pm_enable_wake_irq_complete(struct device *dev)
>  {
> --

Applied as 7.0-rc material, thanks!

