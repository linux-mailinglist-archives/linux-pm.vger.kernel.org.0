Return-Path: <linux-pm+bounces-41762-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONucHdNofGk/MQIAu9opvQ
	(envelope-from <linux-pm+bounces-41762-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:16:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68FB83B5
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 09:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AA973025C6B
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21116352FB1;
	Fri, 30 Jan 2026 08:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/nEQdi9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB4352939
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760937; cv=pass; b=iygbTF1iBbnomVIkaDC/rltuzl79M2n4k5AQm0eWnnBgkxYQTXskKTYJeWm9QP1/p+dgedemXducv0s5qpU2XsNw+DcFGqtLT4Ou8+VkGkzaauAEm3zOe/Rjt4bgJ84nVxx8z93I4Dt0mEG1C9MSRCsFkT4zmI/7xJUvZucCalI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760937; c=relaxed/simple;
	bh=1PP2wyM7jv0kDdb8k1BholOJdOLHYLeXLghCq7d09N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pcfxu6WDey0zwZs73VeDfd0sXIGvqNp0FGHxWz5cwka8nEaMuraEA0Aq0GpytGxk14Aj8FNWD9OlJvLF7qVwyJSdSF8B7wJgxjKwOLpguePqqeUEwo9LquYIDI+M2st81X2fmG/+9oxwUQ68n1eJd5XcHtUjRQz2DEJctkYAlGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/nEQdi9; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-124a635476fso2748774c88.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 00:15:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769760934; cv=none;
        d=google.com; s=arc-20240605;
        b=BnzZnGHarFYoaRj2gj/70p/uVfJPpJwf278kMXM+8mjD8LuraR5l5PdPYZMXmvszje
         z2+/X7l3Cmzibg+OhEOwk023aTmkZPcJqPzXrVneNTPkEVEym4nXFTb8jzAYs7MviBGz
         UOVJ/FuUl6VF5pfC7SRqPqWCYgJ+H5EIeBj7xTsaNLXh0LA4oJFh+nhS6b/tvDp9jcb/
         C1N8LKw2G5PT6ldWu6CAyIzRB5ooefgWw7kDy4EOcN62U4Eow7A6OiSiQNM91RhIe3Gq
         zcN6lxoFQOU7IASYqgbXas5JXqw6Sv/6Bb1P9lUmEgdKTMWebI1R6G9ZrYO0YEvyl6Og
         vxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PP2wyM7jv0kDdb8k1BholOJdOLHYLeXLghCq7d09N4=;
        fh=8ufG2nE/17zUKyOMx72AKWglV6fhRzhOv+cHfDed91E=;
        b=MlRuZRoAl41XxRM/WZUbdFtOt5W4PaFaklT9t+6C6nLspjsws5SPTm7lTxYuLYkVhn
         cVNgMis+BCiHsENq5UIiLOKdnPu7y9Sbw2/OFeRP+w37x68FOgRnGqIYqlB632VI7fse
         b3+iNNGTQVlppR1aP/5xtKdxlvzvRuwLgQA9Uiij7O5Fb7FJr10CudIBdFcsdEcMU//J
         o072qy6jU+OwNi8cQL3pqcnVojbcuDzlbFiena4zZxHts2AbFkINKDlNr9h+9NYMNSnB
         ntJK1cFxVxKXE938pUK2oZFuF/Z2s/qhti4RKWssQAMgRjp1ATifH2oUWHHu4xILtXZ3
         EyNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769760934; x=1770365734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PP2wyM7jv0kDdb8k1BholOJdOLHYLeXLghCq7d09N4=;
        b=F/nEQdi9DlLO2JJ7V3vktmkH/ZzNfSCH49T4D7BS2o4KhJHxdMIlNKsOCSSJWyu7Bu
         Yoz0Qx1e7UupnF3RSoZSXgImhqMKPpQiWdnzYgval5A0KnOPjd32MNlL+/yOSHWtAkxz
         /sEEm+enstykrbmUJUXyM3/q+qsL2ww86WcfizmdRkNeB1Pz5E8mogijS7OILNaWdjz/
         DZwSJ8GD4CWcb2hqLDJK0SDJ9Fcma+Fq7fInbKH6KQBts+bIhHnbXxz0S3HV0FYE1eWy
         rVGUgYQjH+fXZVP/6A77A+F+O/qI7+TYMnWLgoBT3pTu10HlDM8V60lvvBiM/48Yx6VQ
         mzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769760934; x=1770365734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PP2wyM7jv0kDdb8k1BholOJdOLHYLeXLghCq7d09N4=;
        b=NaIagcwpQL8ecHi6OB7a1I8zmuPecrR0mkbW3WDzCCQQDHjLwnt/Ku3layaZJEQmTB
         ewLrm4RSTlGKWYi1dspFL4QVaL+lK6bhH252VepfItxmUS/MHcDms+gAa05GvrzJs/98
         O1CbvtZfHuTPU9/JwMQJyePfFyIEChEdWaI4Xj042extBKwuknvN7FlT9WrapfS62RiQ
         cELqMpYoaZ2HMoIWmawyGg/cCEDe5G9hvZSvY+A89rd7ne5B3uUNSNffmxSjOYPs1i7y
         eCrhNvCKo+43YpDRkcFAt6m5zId2oxQ5yUsn5i1gX+a9H+3MfwyNEc2q3JfMfetOfnd7
         MomA==
X-Forwarded-Encrypted: i=1; AJvYcCUKIF3VuVBAzlAht/4oXfRmi8Ef2pcXIEc3vOKaGluRm36JVqesTjd8Gda3i+T0YpmD9h4Jyd1TEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHhiiINyHfjGalKiOJw23ebICOB10owkLADJ8Oif9uUhx5pgWo
	S+irhK/mjF0XhN3Fd5gcFiZIuHUCIiYH+e59Xft4hHVN3YvL2okjUBAkN+m992JZZqnhJhiRWFL
	2J9+NMMlms6DIPVH1otkD7iQy51EQRbE=
X-Gm-Gg: AZuq6aIwNCDkGyISv5J1d4sRCFw4JkQgtmtcb1HjlEZq8Vwnx3kcKVVD6vmJlKeLijL
	DGBmOMcLNVGVYCQFh5JCMRUhD3wT4RS84p/cv4svQ+Phw3+NVi2/wdiT5ydghVcjlBRbOQgm6V5
	So4C4Iu+43hpmoe6LtdwcOT2lzGjIh2LJq1ieHgsYqiV023+E8HnYQI6mLBj7JRAIIMc1shIM0M
	sEdoknCbFhk9hV5T7w8C8BpIkUTJ5AmZNHfYGrqU/ELPCtsyMR6OOQlBvVnMnXKqhhFoyTi+VgV
	VFMwa/CsqQyDwUSFp7ftigmYVhZUzHtCheb62dIPyT2K/AjSuWtet9o43zLiuW9y/Vrs0n9M+Ac
	7mq7a1ZtAtwKqoQ==
X-Received: by 2002:a05:7022:6190:b0:119:e55a:9c04 with SMTP id
 a92af1059eb24-125c0ff2590mr1058964c88.32.1769760933549; Fri, 30 Jan 2026
 00:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130051107.2130200-1-xu.yang_2@nxp.com>
In-Reply-To: <20260130051107.2130200-1-xu.yang_2@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 30 Jan 2026 10:15:20 +0200
X-Gm-Features: AZwV_Qhfj2kYMNnPMsstGvF02XqNFQQbyZZD7PPVRqDDkgSk9_oYbnDVYaLdLH0
Message-ID: <CAEnQRZAcM+OquwS9Rwh03ca5sbofv7DOePF-0NmB9asrMR_Tew@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx8m-blk-ctrl: fix out-of-range access of bc->domains
To: Xu Yang <xu.yang_2@nxp.com>
Cc: ulf.hansson@linaro.org, s.hauer@pengutronix.de, Frank.Li@nxp.com, 
	kernel@pengutronix.de, festevam@gmail.com, khalasa@piap.pl, 
	benjamin.gaignard@collabora.com, frieder.schrempf@kontron.de, 
	p.zabel@pengutronix.de, shawnguo@kernel.org, l.stach@pengutronix.de, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41762-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,pengutronix.de,nxp.com,gmail.com,piap.pl,collabora.com,kontron.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielbaluta@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2E68FB83B5
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 7:13=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Fix out-of-range access of bc->domains in imx8m_blk_ctrl_remove().
>
> Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
> Cc: stable@kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

