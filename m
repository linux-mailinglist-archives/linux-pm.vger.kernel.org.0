Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840BA3425B8
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 20:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhCSTGB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCSTFq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 15:05:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F3AC06174A
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 12:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OJu1FIdOLMRqMJARpLk/5nKNLWrqCZCUJyegNVwyv70=; b=LWAAaxO2G1UfajDz5kDYnqp5On
        FJHu6aUxPQUnc8DeiM7PQvaZb/EkXg/k/EYEaO4hx18/MFR1ex5SaLQCgIiWRoOpqsa3Hk2/XuGop
        AyFzr9c9SnkDO4T5cM+USTRKW1G3qXw44qB9FjsuWnBbWzh63s1VLgPMZ2USFy3kouLQk1Vv9q8RO
        RCvQXNEjZE1oJ2WzjJ4OVbm+pHVCPgDEtqzaxO5K47fgzYiDM7Tqw5b7uVSqCKlUwdojHWfGmpvoJ
        JVT631zfVIpGgGpI7+HmOf18YpSRdu+QBqb2Dl2T7PUix0zQW67L2DUkaaKVsApArRGs8dKE9WPuD
        GgifCABw==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJUu-001RUa-Iy; Fri, 19 Mar 2021 18:05:21 +0000
Date:   Fri, 19 Mar 2021 11:05:20 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM/devfreq: event: A typo fix
In-Reply-To: <20210319022521.20663-1-unixbhaskar@gmail.com>
Message-ID: <8ae361a8-5fa-7d63-b17c-6ce0ed2fef64@bombadil.infradead.org>
References: <20210319022521.20663-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_110520_646330_51260CF0 
X-CRM114-Status: GOOD (  12.30  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > > s/devie/device/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/devie/device/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> include/linux/devfreq-event.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
> index 4a50a5c71a5f..2489d11e0513 100644
> --- a/include/linux/devfreq-event.h
> +++ b/include/linux/devfreq-event.h
> @@ -56,7 +56,7 @@ struct devfreq_event_data {
>  * @disable	: Disable the devfreq-event device.
>  * @reset	: Reset all setting of the devfreq-event device.
>  * @set_event	: Set the specific event type for the devfreq-event device.
> - * @get_event	: Get the result of the devfreq-event devie with specific
> + * @get_event	: Get the result of the devfreq-event device with specific
>  *		  event type.
>  *
>  * This structure contains devfreq-event device operations which can be
> --
> 2.26.2
>
>
