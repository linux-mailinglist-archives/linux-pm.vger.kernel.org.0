Return-Path: <linux-pm+bounces-34463-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3D0B53210
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571837AFD04
	for <lists+linux-pm@lfdr.de>; Thu, 11 Sep 2025 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0E9321424;
	Thu, 11 Sep 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UvOLrkMH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462AE23D7D1;
	Thu, 11 Sep 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593734; cv=none; b=rLNsM/QQbaB2vWd7Xx3bjeOdpki6fN5Rv7sxCJqFAaQ6JzicqrXzp2LasGCLN/5sUHc+crDtzbvryUQQgOWFGudzsI/DSfooIJ+Zpkiqzl2zGAMqaahufo8KnNeQ0lSlSAKLje+21D8PmXR/V30o7J+4I6aQU4OSjHXwe1BC2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593734; c=relaxed/simple;
	bh=cOxH4L+r13ac6AWe2+G4yXqo8aVVu5wvCvByGl2iHkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiQlX0A74OCsnv8FqoGwGVgc+ZWJ2ik0CHvTu3VVkGQSEFXogwUA4c4UO1fHLq6BOnq5yNN0gwQL8eqXKFIiHmPfEfpxhR/kiLcT/0KT2lMa+1UjKaaWXV2Et273p89nIzekYElpf+GrbTuwv1Rs4vp+u8UPlUxNfINNQ3juNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvOLrkMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B913C4CEF0;
	Thu, 11 Sep 2025 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757593733;
	bh=cOxH4L+r13ac6AWe2+G4yXqo8aVVu5wvCvByGl2iHkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvOLrkMHmOSr7Ireijjhav+ydIi780aZXaoV0O0BGMrOMxLn5+UvlKW9VbQhP6nmp
	 IT9X8DURLQCtz20pPbCtJKvXAZa8yPAEVF9IRCwRVichVIxoBCirEECJHy8RpEUO2y
	 7YJS/JpEY661ATtGqNwBCLL+nw/XpHlDp+jl4ilQ=
Date: Thu, 11 Sep 2025 14:28:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pin-yen Lin <treapking@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>, linux-pm@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PM: sleep: Don't wait for SYNC_STATE_ONLY device
 links
Message-ID: <2025091129-harmonics-clambake-6240@gregkh>
References: <20250911112058.3610201-1-treapking@chromium.org>
 <20250911112058.3610201-2-treapking@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112058.3610201-2-treapking@chromium.org>

On Thu, Sep 11, 2025 at 07:16:03PM +0800, Pin-yen Lin wrote:
> Device links with DL_FLAG_SYNC_STATE_ONLY should not affect suspend
> and resume, and functions like device_reorder_to_tail() and
> device_link_add() doesn't try to reorder the consumers with such flag.
> 
> However, dpm_wait_for_consumers() and dpm_wait_for_suppliers() doesn't
> check this flag before triggering dpm_wait, leading to potential hang
> during suspend/resume.
> 
> This can be reproduced on MT8186 Corsola Chromebook with devicetree like:
> 
> usb-a-connector {
>         compatible = "usb-a-connector";
>         port {
>                 usb_a_con: endpoint {
>                         remote-endpoint = <&usb_hs>;
>                 };
>         };
> };
> 
> usb_host {
>         compatible = "mediatek,mt8186-xhci", "mediatek,mtk-xhci";
>         port {
>                 usb_hs: endpoint {
>                         remote-endpoint = <&usb_a_con>;
>                 };
>         };
> };
> 
> In this case, the two nodes form a cycle and a SYNC_STATE_ONLY devlink
> between usb_host (supplier) and usb-a-connector (consumer) is created.
> 
> Use device_link_flag_is_sync_state_only() to check this in
> dpm_wait_for_consumers() and dpm_wait_for_suppliers() to fix this.
> 
> Fixes: 05ef983e0d65a ("driver core: Add device link support for SYNC_STATE_ONLY flag")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
> Changes in v2:
> - Update commit message
> - Use device_link_flag_is_sync_state_only()
> 
>  drivers/base/power/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 2ea6e05e6ec9..73a1916170ae 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -282,7 +282,8 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
>  	 * walking.
>  	 */
>  	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
> -		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
> +		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
> +		    !device_link_flag_is_sync_state_only(link->flags))
>  			dpm_wait(link->supplier, async);
>  
>  	device_links_read_unlock(idx);
> @@ -339,7 +340,8 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
>  	 * unregistration).
>  	 */
>  	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
> -		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
> +		if (READ_ONCE(link->status) != DL_STATE_DORMANT &&
> +		    !device_link_flag_is_sync_state_only(link->flags))
>  			dpm_wait(link->consumer, async);
>  
>  	device_links_read_unlock(idx);

The way you use this new function does not require it to have been
exported to modules :(

thanks,

greg k-h

