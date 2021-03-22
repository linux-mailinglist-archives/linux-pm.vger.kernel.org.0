Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3C3440B0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCVMSG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 08:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCVMSA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 08:18:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFD926198B;
        Mon, 22 Mar 2021 12:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415479;
        bh=OCGroSzoea7Tio0hzjYpY94geU8QRE+SyEOWwi3ZkT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tX7XBWe+1bHcWf6Opz6XnEN8axjgt0qe8kay9Rm/q8+vVQhlfTVsrzykp/S4mG8GH
         UERd0r0IpN2KjSY3h3oL8DKiF6LJ2YrrYF3qcooiPHz3cZQv7lJy2ci+ncjU023jCu
         zQMBiazIGjWm/OzT5heFa3NPYaxoZamn2ztUcVy2sa9PcSx0O/5OJ5BoOgRVlv3MdJ
         8mdMCpRfu0rJL+rPQm+0bm/Ty5ncbnggPI5QaVdn2keX/r0h66/tv+yg5Hu1vuPD0r
         9PYzJ7HH9MZDagZvrVBC6hfx1+DuJ8WWHDybf5mSFS5KXXxQMLRHbJ3bcIs44kTYL3
         2vrAu7LgMek2g==
Date:   Mon, 22 Mar 2021 17:47:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: qcom-tsens: Add compatible
 for sm8350
Message-ID: <YFiK80LTB5tsHBUN@vkoul-mobl.Dlink>
References: <20210322100420.125616-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322100420.125616-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-03-21, 11:04, Robert Foss wrote:
> Add tsens bindings for sm8350.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
