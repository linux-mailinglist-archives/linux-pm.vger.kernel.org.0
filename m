Return-Path: <linux-pm+bounces-20539-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B61A13A1B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC881188A6EF
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0531DE894;
	Thu, 16 Jan 2025 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQsqMYoq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5371DE882;
	Thu, 16 Jan 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031399; cv=none; b=QzgRkgts9ldnYBOg6tKJJlErhb2wZ+7K6KzSI6v2NjpMnjMb6Go4AsnpCqoPxOxzCIRcJRkK2BW0tv4UrBhLTQHYmZl7CkYH7nqZBzWpQHW+21tyNv4Mf5J6uSC4EK6Gr6fbhfPuARbK9UVgtTn79PWzKgRpkhm06gvP/noh0c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031399; c=relaxed/simple;
	bh=Z9xxJgvMHRzzRJky/45S296SmFnF8IICOKTAP/cTjUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tDDqnykplsCsINq1AFYTC7e/naQfUGocHV1eobIXd2l3HOSzf+WqMldtzzfrao8mslAkjqS8xeBIlnQ4FET/soCQJhZPZ0iEmFRzO9JRoo+vN1idzD5kosqVQL6DQk2HWfU1mNm+ikbKpeu5a/Qej+DB3hz8yBZctuf9+K9a8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQsqMYoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6618FC4CED6;
	Thu, 16 Jan 2025 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737031398;
	bh=Z9xxJgvMHRzzRJky/45S296SmFnF8IICOKTAP/cTjUg=;
	h=From:To:Cc:Subject:Date:From;
	b=PQsqMYoq+wf19A/OOiyTgwBxo0e34b4ndk8W8Q3+gedUYFcXsXreBFZyJoz9aaGPH
	 EopQke5bPx7LeesY85knshjNBXMoLV9w3l2MnFueSk4o9PuLkOZ/+HNknycXGKxM+8
	 Hv66iF1CytxO35Kri6pVePMyIbwQqSFFbYRGxweeE+ixMKRD6LEBtzq5pPZTus5Y+z
	 rmjH2yPva1C6pTvly2teLtlrxxONBsfnyjyw3kUwVYmYFuPRUt1EnDXuNz5GNSRi8y
	 pz4wKIf3EDFJUZZDl5RKbdA6uPg2G0M4Q8oNkK51VtoZBbLeiu13axa30m0mNQtwSJ
	 rXs0Wu7NeSEyA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.14
Date: Thu, 16 Jan 2025 14:42:30 +0200
Message-Id: <20250116124230.635223-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v6.14-rc1 merge
window. It contains a new driver and tiny DT binding updates. As always,
the summary is in the signed tag.

All patches have been in linux-next for a while. There are no reported
issues. Please pull into char-misc-next when possible.

Thanks,
Georgi


The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.14-rc1

for you to fetch changes up to 4cc004716977beab6242bca385326c84db127256:

  Merge branch 'icc-sm8750' into icc-next (2025-01-14 00:13:23 +0200)

----------------------------------------------------------------
interconnect changes for 6.14

This pull request contains the interconnect changes for the 6.14-rc1 merge
window. It contains one new driver and DT documentation updates for L3
and bandwidth monitors.

Driver changes:
- New driver for the SM8750 platform
- Add DT compatibles for QCS615 BWMON and SM8650 OSM

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (1):
      Merge branch 'icc-sm8750' into icc-next

Krzysztof Kozlowski (1):
      interconnect: sm8750: Add missing const to static qcom_icc_desc

Lijuan Gao (1):
      dt-bindings: interconnect: qcom-bwmon: Document QCS615 bwmon compatibles

Neil Armstrong (1):
      dt-bindings: interconnect: OSM L3: Document sm8650 OSM L3 compatible

Raviteja Laggyshetty (2):
      dt-bindings: interconnect: add interconnect bindings for SM8750
      interconnect: qcom: Add interconnect provider driver for SM8750

Shivnandan Kumar (1):
      dt-bindings: interconnect: qcom,msm8998-bwmon: Add SM8750 CPU BWMONs

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    3 +
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    1 +
 .../devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml     |  136 +
 drivers/interconnect/qcom/Kconfig                              |    9 +
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/sm8750.c                             | 1705 ++++++++
 include/dt-bindings/interconnect/qcom,sm8750-rpmh.h            |  143 +
 7 files changed, 1999 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/sm8750.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8750-rpmh.h

