Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2102485E7
	for <lists+linux-pm@lfdr.de>; Tue, 18 Aug 2020 15:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRNR6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 09:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHRNR5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2020 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597756675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0uI96kuUyz81rQQhwBKLrJwcZelZomkWIsH60DHRcU=;
        b=KfcPHdwNBrbstjzcGUfWe1BGjmjxRNaek36iCijfj/FW63bFi/TIpU9EA39hwuTxNcaL6X
        4eByMZdUr3Oa81GJQAQ5XTqCWtXqCowQkJvYM9Y9hQvvamZmLrJBZdfv+h0e4Sv0skCHOY
        KOsCqpV3LqCSEZuO2K2bhzrPlD3KjiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-6tH6VciYN8G9RuEwLPJ1Eg-1; Tue, 18 Aug 2020 09:17:51 -0400
X-MC-Unique: 6tH6VciYN8G9RuEwLPJ1Eg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDC58100CECC;
        Tue, 18 Aug 2020 13:17:49 +0000 (UTC)
Received: from darcari.bos.csb (ovpn-114-148.rdu2.redhat.com [10.10.114.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93E9426327;
        Tue, 18 Aug 2020 13:17:49 +0000 (UTC)
Subject: Re: [PATCH] tools/power turbostat: fix output formatting for ACPI CST
 enumeration
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
References: <20200810144330.75613-1-darcari@redhat.com>
From:   David Arcari <darcari@redhat.com>
Organization: Red Hat
Message-ID: <bd35e393-f52d-0ac3-67bb-fbe52486f89f@redhat.com>
Date:   Tue, 18 Aug 2020 09:17:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200810144330.75613-1-darcari@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

Just want to make sure that this doesn't get lost.

Please let me know if you feel there is a better approach.

Thanks,

-Dave

On 8/10/20 10:43 AM, David Arcari wrote:
> turbostat formatting is broken with ACPI CST for enumeration.  The
> problem is that the CX_ACPI% is eight characters long which does not
> work with tab formatting.  One simple solution is to remove the underbar
> from the state name such that C1_ACPI will be displayed as C1ACPI.
> 
> Signed-off-by: David Arcari <darcari@redhat.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/power/x86/turbostat/turbostat.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 33b370865d16..5f074879cc0a 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -3474,6 +3474,20 @@ int has_config_tdp(unsigned int family, unsigned int model)
>   	}
>   }
>   
> +static void
> +remove_underbar(char *s)
> +{
> +	char *to = s;
> +
> +	while (*s) {
> +		if (*s != '_')
> +			*to++ = *s;
> +		s++;
> +	}
> +
> +	*to = 0;
> +}
> +
>   static void
>   dump_cstate_pstate_config_info(unsigned int family, unsigned int model)
>   {
> @@ -3559,6 +3573,8 @@ dump_sysfs_cstate_config(void)
>   		*sp = '\0';
>   		fclose(input);
>   
> +		remove_underbar(name_buf);
> +
>   		sprintf(path, "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/desc",
>   			base_cpu, state);
>   		input = fopen(path, "r");
> @@ -5597,6 +5613,8 @@ void probe_sysfs(void)
>   		*sp = '%';
>   		*(sp + 1) = '\0';
>   
> +		remove_underbar(name_buf);
> +
>   		fclose(input);
>   
>   		sprintf(path, "cpuidle/state%d/time", state);
> @@ -5624,6 +5642,8 @@ void probe_sysfs(void)
>   		*sp = '\0';
>   		fclose(input);
>   
> +		remove_underbar(name_buf);
> +
>   		sprintf(path, "cpuidle/state%d/usage", state);
>   
>   		if (is_deferred_skip(name_buf))
> 

