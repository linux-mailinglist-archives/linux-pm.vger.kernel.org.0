Return-Path: <linux-pm+bounces-851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B454F80B38D
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 11:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF131F20FF1
	for <lists+linux-pm@lfdr.de>; Sat,  9 Dec 2023 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E3D11184;
	Sat,  9 Dec 2023 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuBC5uFE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B946746A
	for <linux-pm@vger.kernel.org>; Sat,  9 Dec 2023 10:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B24C433C7;
	Sat,  9 Dec 2023 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702116986;
	bh=6lAtUj0w6cfsqWJL+DsezEwY42RXIvFrsgiRpaPq1Po=;
	h=From:To:Cc:Subject:Date:From;
	b=LuBC5uFECTdiFavsl4AnVB/3EkhvXih8ZKxdb2Qc2oDic8U4tbikFjcrx9fyc4ZHo
	 mcvXY0jCAVx3xjSc5vQASmX2DmASAPZQ35PUr41/BOfRh8NWEar+zDcbZm7zi8F2sP
	 dBLpAQ91tOzMMlL9W/4f2kyMeE3sny2L9Nox/1G8dH9toX26L+QjqY2pV2UcuAlYhh
	 DRlsIvJ/YfbhiRTs3XJI0LWQIYYL1lR9mCWyrTX2ixBDUgyH02hyxXVAl9ZGqw1L3K
	 1HjM23bpoS4+HWjcywKFmPs2fgk/JJFap3sMTnvqHiAdB7cDS33t24xyFLpjDz6QN/
	 y4cn8iaOPd3AA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.7-rc
Date: Sat,  9 Dec 2023 12:15:48 +0200
Message-Id: <20231209101548.1240700-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This pull request contains a few tiny fixes for the current cycle. The
details are in the signed tag. All patches have been in linux-next
during the last few days. Please pull into char-misc-linus when possible.

Thanks,
Georgi


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.7-rc5

for you to fetch changes up to 9085b23b668ad5aca62df4f071b306a47152e6b3:

  interconnect: qcom: icc-rpm: Fix peak rate calculation (2023-12-06 17:00:42 +0200)

----------------------------------------------------------------
interconnect fixes for v6.7-rc

This contains fixes for reported issues. One fix is in framework code to
explicitly treat returned NULL nodes as error when the device-tree data
is translated into endpoint nodes.
The other two fixes are in driver code. One is expected to improve the
power consumption on the sm8250 platforms and the other one is fixing a
bandwidth calculation formula that was introduced during this cycle.

- interconnect: Treat xlate() returning NULL node as an error
- interconnect: qcom: sm8250: Enable sync_state
- interconnect: qcom: icc-rpm: Fix peak rate calculation

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Bjorn Andersson (1):
      interconnect: qcom: icc-rpm: Fix peak rate calculation

Konrad Dybcio (1):
      interconnect: qcom: sm8250: Enable sync_state

Mike Tipton (1):
      interconnect: Treat xlate() returning NULL node as an error

 drivers/interconnect/core.c         | 3 +++
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 drivers/interconnect/qcom/sm8250.c  | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

