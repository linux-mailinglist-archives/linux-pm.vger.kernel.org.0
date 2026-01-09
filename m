Return-Path: <linux-pm+bounces-40521-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88232D07C26
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B9C23012CEB
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29952F5A29;
	Fri,  9 Jan 2026 08:20:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096A19E7F7;
	Fri,  9 Jan 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946852; cv=none; b=c14MmMs1BDwxH32bGZcjyha3u19Ao3Xqs2R9uS/WhDH+YRMqnY6UkKqx/Wr9wsQG/VV0HcZ7Zf9kOFimPYpEK1H/Lc0l7lywnjRY9d7nmLL2atqbqZc7Gvs8fdozxdGzk8Mu2FI7xvfw/HTVfSi5wwvUmA3/PFkNgwZS1py4DvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946852; c=relaxed/simple;
	bh=IPdXIPCYG8+L/O2S05oWy0IPp0NYbvWGcrk+1ftgBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1HKWk2PjcG5x5maMtvFw6CGgWbma30qb79F5W4gCfGG8pPrrj8MjD8wRJRR5+X6wwJiFzeZcAeB5lYqZ5MlWkq4fFA1/EprE5QXl9j6yju4bbYivb8ckIs7sqFguMFaLXBd4rsSyBk4UufieIMAJdoMq1s5qJvmf3KnnbPvW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC254C4CEF1;
	Fri,  9 Jan 2026 08:20:51 +0000 (UTC)
Date: Fri, 9 Jan 2026 09:20:49 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: serial: google,goldfish-tty: Convert
 to DT schema
Message-ID: <20260109-observant-eccentric-starfish-8e9e9f@quoll>
References: <20260108080836.3777829-1-visitorckw@gmail.com>
 <20260108080836.3777829-2-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108080836.3777829-2-visitorckw@gmail.com>

On Thu, Jan 08, 2026 at 08:08:31AM +0000, Kuan-Wei Chiu wrote:
> Convert the Google Goldfish TTY binding to DT schema format.
> Move the file to the serial directory to match the subsystem.
> Update the example node name to 'serial' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v2:
> - Add reference to serial.yaml schema.
> - Change additionalProperties to unevaluatedProperties: false.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


