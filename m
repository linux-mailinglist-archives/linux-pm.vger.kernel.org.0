Return-Path: <linux-pm+bounces-639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D875E801D9B
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C3B2814EE
	for <lists+linux-pm@lfdr.de>; Sat,  2 Dec 2023 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DC61A5A6;
	Sat,  2 Dec 2023 15:57:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A58F11F;
	Sat,  2 Dec 2023 07:57:28 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1r9SMq-0002DL-9W; Sat, 02 Dec 2023 16:57:20 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	linux-pm@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	devicetree@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/5] Add power-controller and gpu for RK3128
Date: Sat,  2 Dec 2023 16:57:18 +0100
Message-Id: <170153263025.376455.12737085983971621612.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231202125144.66052-1-knaerzche@gmail.com>
References: <20231202125144.66052-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 2 Dec 2023 13:51:39 +0100, Alex Bee wrote:
> The first patch in this series fixes the pm-domain driver and adds
> power-domains which are currently missing. This touches the ABI which is
> not and was never used until now. Not all of them are used yet, but when
> the power-controller is added to the DT in patch 2 the ABI should not
> be changed again.
> Patch 3-5 are adding the the gpu compatible to dt-bindings, adding the gpu
> node and the respective operating points to SoC DT and finally enabling it
> for XPI-3128 board.
> 
> [...]

Applied, thanks!

[3/5] dt-bindings: gpu: mali-utgard: Add Rockchip RK3128 compatible
      commit: 5d86c15c3171c3ecebd84d53e30d9812b5591c84

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

