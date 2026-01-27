Return-Path: <linux-pm+bounces-41541-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FZmKmnNeGmNtQEAu9opvQ
	(envelope-from <linux-pm+bounces-41541-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:36:25 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB2795D1C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0867317309C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9383835CB73;
	Tue, 27 Jan 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvFMQJ4g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D973B35B63F
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524078; cv=pass; b=XLx6EenvigD2sCqGo5E0mCwRYypVDZkai5hcQ0GdZAN8mMleQVyZHeGnSJvANfGcSmlXi7jwI12hcjH/wkYRnCZqp3HtGhpP68RjQ2w0Zz1Mqo8jeJGqsihDme0+eZ5ysNjPCV7uHQ4U6GMr35/DmJQ1Ck4rHPXvD1ejxR3J/do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524078; c=relaxed/simple;
	bh=SYsG+RVz9eLQyTlia9fufMVAFPXhbhQ57zjotGeFv0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0zQP3z7SrMXtmzUlr+6BsdRjDKQPzpud+2oDOYezZUCFywKVKafv+Rq6Pz8+pfPgY3qfbcxma0NiKTj0HKxcCnWQZWGYYbvCc/9LvMg37QNnYCW9lm+42xTzozNCr2k25qoAudXA1mlL1iPwdfP3NSb8Uj03ScSMDgTgdMjvrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fvFMQJ4g; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59dcd9b89ecso7152489e87.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:27:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524075; cv=none;
        d=google.com; s=arc-20240605;
        b=Hmz930RdEJHOwSN1ofouIQTGmF/R3BKGT29AEORL+P7DCEDdgkQrjjpSt0Ty1b+RKe
         DB+X7NT3FT6lpG+pmGn+g7jhqxRg2jWuMoo5Po7TZ8tp3nT9f93nHnVVC9MO4jNYl1Pj
         E8MMeUROWSm8oKgXIlAxaLkAFbWHtGeHpD3N0afWM57SkMfJsmuIAbdeL2BOnNYeFrw5
         TW8JCGLjMW42Juy6Q/fxQjZjiMGdT5uZTPnwSUngHCZ7U3VzDHLbqKgo995slezo5tDM
         C+98wihDFv4hYFKWynFu/qVLVSiaSTFUrGC3sbthjeuR9zJQXOhL64XF8ibfQj0UXV8J
         OI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bixFc51zHggwjEg6bYco2p0W03PflnDZlTMDYcdiHMM=;
        fh=5Dx8Nlxs9Go7iwsIA2AcaWmT0xOCbVABZWLRcervCXw=;
        b=j6YrAJwkNYfVxwli7fOlQwE2OWpMY0c6Mn86TYqmK00EpEIPBbMD+HDlO+2wq1kR1M
         S+fQXzBvSYlCWuZOJzva4W5Hh98vMiVPEmbNvgpjbiJc5dLTKQZPSsyMI6AmFQktWKbs
         luDoGNqzEABQ/m3iM/+Gwqeemhvw9Jk+03adP4eOw6hx1b8wu0P+N/n3lT6PyHbf84Cs
         q/UhgqwhkRebrtLhLK6ifrM74hrpLSnBRFsOj1e8fr4iEeBhbLuphomqHY2KvTyv+6sZ
         lHR69La4eQ136xwfOurc0fceAJYZvXUIaPccsdFohsok4KXizmuekUIl6s8SxIyZYm8x
         AzYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769524075; x=1770128875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bixFc51zHggwjEg6bYco2p0W03PflnDZlTMDYcdiHMM=;
        b=fvFMQJ4gfGi92gfwUD9WjZ9ub8d3SSmOuIZvWCzHJ0hCvUr6AI3JQHsJ5Esf/wrTzw
         5rAbQBYiKmb2AKNLrGr8SoUyWTUxVG1Bt0LienMEA3Lvm/Qm1YAxCmv4j2ugYHRgZzbY
         xH13Vr8O/s47CBEx8ej5cdjFIm/H/vj09DVJIel8i7n+sj9MmYj+FzRiLJa8dTyfDAKJ
         Eu1uADCvZueHENRA868ZGYffIaaKAXYmhj+zoSPyqIvH2FG3qAND+jciIjziOYUhIl8a
         G21BJkJkJpgSRm6EIHO76O0tmRQdF6d/ZZS5gxp8bIdR+wAXg1EwMTeNc/BNmMo4SYdX
         ssQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524075; x=1770128875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bixFc51zHggwjEg6bYco2p0W03PflnDZlTMDYcdiHMM=;
        b=Ojhw2L0Z5RUXX+9TATJwbfYRZxrtqvEwgFQKkFwP1VdjDoERK8bDCtppPOy9IL8o1F
         t1DVxNRAfEMZaKriob6zCBJZQFILLAAWv2E7Gj8nIv9NkMpIBxKrw01QfPm88M0sbo56
         4HAGOLgQ8/JfO5yXae3uCse3PyA6LT3wcu8FJL1Gl/LUdRRMMUy/FgnfidV94PJGOCp+
         wrAtvl036WnRM8o3lGSm31IyVxUzwGtZ4rhS23tD8fj9VwHN/nk7FoorngvNrfRcYD7Y
         BIgEdZD5oBHOZshouD9op62CfGolvDJEQnvNMUb/MXMpcBzdz7Gi//4WuDzEj6+WSAZo
         SUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaEajq2s1u61D07DtgPqdQhoffCkgA3nxgpvGQf4ZB+QqxZGIr63N2Qd0nDA9XDQhw+Ch/67e4gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOvN+BUbHtotHDbQ60F+h4BoZ4zxROEh3GqA8U4Bd08IG5dM8
	cohQAFP9/kD5H4LMP9vTM47b6v/wZUFxx0mAbETpjKxJnqgUt96EnWgcTa03m2c8HDSt15pE/wy
	ZgFz/xPFNVehJp9swGFL7X4e00QBO6eoKzEya69i59g==
X-Gm-Gg: AZuq6aIzGqWwYQWmteXUFbQ+ea+TTll6Wab9dXQkUBvQRu0Lm52JZyazDhsctFu/fcv
	oP0rd+iXKrPvgRClGmNgo+8KWPPIZNriSPssD1RIoRk2tODmbsJa61JwBAczaml66usWtpcp2Fk
	q9LvidEgJmkNH77+UffMKEE2EsKhvONkk7BsCC3JetSkBr63WbVtmewYjtbFJYHgJ+7qf/Ope/G
	Hb97GhEsnM5zgJCiRJGrZ7CjdMgT9vT0lz1o5oRTt6XJVOl9igPfFlrfii+4ZnBpXzUe8Ym
X-Received: by 2002:a05:6512:2312:b0:59c:bf32:26fb with SMTP id
 2adb3069b0e04-59e0401e3c4mr975834e87.2.1769524075019; Tue, 27 Jan 2026
 06:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-qcom-rpmpd-semicolon-v1-1-9bbdd9478ba8@gmail.com>
In-Reply-To: <20260121-qcom-rpmpd-semicolon-v1-1-9bbdd9478ba8@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 15:27:19 +0100
X-Gm-Features: AZwV_Qhnx3ee7nXtzcBaurlEhXjdnBHlTXVsUOF4f979GZrgQoW9map96vZbscs
Message-ID: <CAPDyKFpSaaiCwk6wHrygQCbtHaWJ7R8r_xNDpBWZNfbn1z0SCA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmpd: drop stray semicolon
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41541-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linaro.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 0FB2795D1C
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 17:18, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> Drop the unnecessary semicolon after the rpmpd_send_corner()
> function's declaration.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/rpmpd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
> index f8580ec0f73785544aeb6f686438f39b477d134d..a7b311f966a04210dbb499066cd1105e2c621cd5 100644
> --- a/drivers/pmdomain/qcom/rpmpd.c
> +++ b/drivers/pmdomain/qcom/rpmpd.c
> @@ -978,7 +978,7 @@ static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
>
>         return qcom_rpm_smd_write(rpmpd_smd_rpm, state, pd->res_type, pd->res_id,
>                                   &req, sizeof(req));
> -};
> +}
>
>  static void to_active_sleep(struct rpmpd *pd, unsigned int corner,
>                             unsigned int *active, unsigned int *sleep)
>
> ---
> base-commit: 95fad101a21d31b4facd1b9e0713bba1c517db6e
> change-id: 20260121-qcom-rpmpd-semicolon-1f985a101e0b
>
> Best regards,
> --
> Gabor Juhos <j4g8y7@gmail.com>
>

