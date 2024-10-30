Return-Path: <linux-pm+bounces-16687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 694C19B58BD
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 01:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C308528400E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8CF19BA6;
	Wed, 30 Oct 2024 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBVHil7P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE711AAD7;
	Wed, 30 Oct 2024 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248860; cv=none; b=W1d1zMwLkbKlLIRBJPiA05bUXYZHx5ehx/pqZGElkb49MyiEom7O1B6PQaiSkbR7hF1ZEzDNlV5eMs6OjlmSI5/00z2cjX5MGeog/qARPvZRzmC9JxWqtab5RjICyIJk869PDRSkxRcSDCIdN84lw6zAJh846F/ulj6X3kunDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248860; c=relaxed/simple;
	bh=VDQMFPrKxlMhz1aUAMz83CqSyTiE8wcdm2ljHR+1PUk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=ovdZ5ZwleG81R2E9TcHDJd3a4rQbAlXBZym2lQcl2qcYxtebMpoE2Lmxc8FZZHJ03VNBFVMCmLoQSKofzE01ZvH/JB6adv7QL4FxKZei7eCbQb6lC7/tNYpb56cBv0+6bEkyM/9vmtFcU5/dV1MgVWtwgwvRtXtTFgHV0IYYW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBVHil7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D47C4CECD;
	Wed, 30 Oct 2024 00:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248859;
	bh=VDQMFPrKxlMhz1aUAMz83CqSyTiE8wcdm2ljHR+1PUk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YBVHil7Pq3+59Lt49I5fTeu51WIHalVOcjBN/o2fLzr+kmN5B8SatNl/VlzZROn8A
	 9J5w5eUElC2q/bQ1ATCZkw8L7SXy/+upXU1WtNuwLlnzTENT1/wzJBLIcA+uBfITcR
	 zdIHDnpeQRLRLSQs0L9lnRvfwB6hsapDgLJ8aS6XR3kQRRFVB8N6BgQ3MeGkwbPuFy
	 Opkn3TpcKzpq6rNDOgSrbTASoHODWeQMimjF+HoWzPUK+uh74qNgGiLwbpbBCDvcsA
	 3AqCsBfG2kCX4lNGQNjgLZBtCo0EckfAVnibVvgkTPX78oVgG8lB9J1jvWtPsLNyuo
	 J2dgu1uN/mVSg==
Message-ID: <b587012e868f8936463c46915b8588c3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6f14d8d7-7b9a-49e3-8aa8-5c99571a7104@linaro.org>
References: <20241028163403.522001-1-eugen.hristev@linaro.org> <bb5d855954d5ff8694a3978a9f87a9d2.sboyd@kernel.org> <6f14d8d7-7b9a-49e3-8aa8-5c99571a7104@linaro.org>
Subject: Re: [PATCH v2] soc: qcom: Rework BCM_TCS_CMD macro
From: Stephen Boyd <sboyd@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, djakov@kernel.org, mturquette@baylibre.com
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org
Date: Tue, 29 Oct 2024 17:40:57 -0700
User-Agent: alot/0.10

Quoting Eugen Hristev (2024-10-29 06:12:12)
> On 10/28/24 19:56, Stephen Boyd wrote:
> > Quoting Eugen Hristev (2024-10-28 09:34:03)
> >> diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
> >> index 3acca067c72b..152947a922c0 100644
> >> --- a/include/soc/qcom/tcs.h
> >> +++ b/include/soc/qcom/tcs.h
[....]
> >>   /* Construct a Bus Clock Manager (BCM) specific TCS command */
> >>   #define BCM_TCS_CMD(commit, valid, vote_x, vote_y)             \
> >> -       (((commit) << BCM_TCS_CMD_COMMIT_SHFT) |                \
> >> -       ((valid) << BCM_TCS_CMD_VALID_SHFT) |                   \
> >> -       ((cpu_to_le32(vote_x) &                                 \
> >> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_X_SHFT) |    \
> >> -       ((cpu_to_le32(vote_y) &                                 \
> >> -       BCM_TCS_CMD_VOTE_MASK) << BCM_TCS_CMD_VOTE_Y_SHFT))
> >> +       (le32_encode_bits(commit, BCM_TCS_CMD_COMMIT_MASK) |    \
> >> +       le32_encode_bits(valid, BCM_TCS_CMD_VALID_MASK) |       \
> >> +       le32_encode_bits(vote_x,        \
> >> +                       BCM_TCS_CMD_VOTE_X_MASK) |              \
> >> +       le32_encode_bits(vote_y,        \
> >> +                       BCM_TCS_CMD_VOTE_Y_MASK))
> >=20
> > Why is cpu_to_le32() inside BCM_TCS_CMD at all? Is struct tcs_cmd::data
> > supposed to be marked as __le32?
> >=20
> > Can the whole u32 be constructed and turned into an __le32 after setting
> > all the bit fields instead of using le32_encode_bits() multiple times?
>=20
> I believe no. The fields inside the constructed TCS command should be=20
> little endian. If we construct the whole u32 and then convert it from=20
> cpu endinaness to little endian, this might prove to be incorrect as it=20
> would swap the bytes at the u32 level, while originally, the bytes for=20
> each field that was longer than 1 byte were swapped before being added=20
> to the constructed u32.
> So I would say that the fields inside the constructed item are indeed=20
> le32, but the result as a whole is an u32 which would be sent to the=20
> hardware using an u32 container , and no byte swapping should be done=20
> there, as the masks already place the fields at the required offsets.
> So the tcs_cmd.data is not really a le32, at least my acception of it.
> Does this make sense ?
>=20

Sort of? But I thought that the RPMh hardware was basically 32-bit
little-endian registers. That's why write_tcs_*() APIs in
drivers/soc/qcom/rpmh-rsc.c use writel() and readl(), right? The
cpu_to_le32() code that's there today is doing nothing, because the CPU
is little-endian 99% of the time. It's likely doing the wrong thing on
big-endian machines. Looking at commit 6311b6521bcc ("drivers: qcom: Add
BCM vote macro to header") it seems to have picked the macro version
from interconnect vs. clk subsystem. And commit b5d2f741077a
("interconnect: qcom: Add sdm845 interconnect provider driver") used
cpu_to_le32() but I can't figure out why.

If the rpmh-rsc code didn't use writel() or readl() I'd believe that the
data member is simply a u32 container. But those writel() and readl()
functions are doing a byte swap, which seems to imply that the data
member is a native CPU endian u32 that needs to be converted to
little-endian. Sounds like BCM_TCS_CMD() should just pack things into a
u32 and we can simply remove the cpu_to_l32() stuff in the macro?

