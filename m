Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D132FF6C9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Jan 2021 22:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbhAUVFc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jan 2021 16:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbhAUVC4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2021 16:02:56 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D906C06174A;
        Thu, 21 Jan 2021 13:02:15 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id p13so4141695ljg.2;
        Thu, 21 Jan 2021 13:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HTSI5kPzLoA4thqADbG4CT4ZHn9/tnIJfNYkNNeKGi0=;
        b=pL5Ut6SetM5MPOm/3ixVXBM3DPvSn7HbiYCbSxTe4Ys7us9j7lJnVR+jlWE1sjup58
         8buGxJAu5vvM3HAi6kpWSegsvF9IXz9zR6u2oq6SeDfvET2xuL2A9OQ3f4N4jfwSoPmT
         QUhDxmGKn9WzMZ+fpeXnKtow5vK2CTRLkUBO2e9V/7E28TdvTacN3ODwGM4LlNmj/wHW
         2SUeETpzKAuOG9X8M6or3ny3Jl3QHT9HKw19XV4fI40DIsqeS6OUchOXFlczrtwwekr6
         bIBNBIRZUHJd+/kDuz8vXsR35GRgnXqRTC7wfNVxusUaOpeh1QTgGaWnEqymUEH8lwpT
         lHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTSI5kPzLoA4thqADbG4CT4ZHn9/tnIJfNYkNNeKGi0=;
        b=JEp3Vbbzi6OQ0HREZB5+k7m7QDUjOm1n5J0D4sy5XHlDicl0S7ee1kY4tdMBCRmRQ0
         4+SAxwc1X1O61/V6kaiShptPi6JbY8y5QzDXuIf9dgwdRIMJ2Y22YNKKOWJKfygpLoXs
         smjLp8KT/Zs4Ky9pDJZtQ/sQxW1vKcwD4C5HTtNREC8PUWH9TpPypvi8wg2Z6KqiiBK6
         ZrXJHCKs8VSTOZ9JvxGhf/sKqqPksJ3JvNlWhfSXzCogw1t37ISjt6hUqqftrvPDxRdS
         ZY4rw1xhZE4vdPeNIAFbDupbK8pYyWvdJ/vxHzS9kQ2kz0Y/ENFPSEwvPf03J5Z/N7DV
         ImjA==
X-Gm-Message-State: AOAM531DBmHz4oqmf7O3Ef/9pZ27K3M7EWj17lAcW8R1I1fEDXeSzb+A
        b0b54KNu6pehzkBe6ZuYWZIOnaKYIv4=
X-Google-Smtp-Source: ABdhPJysbwgbBj7t7ErG5NYCTp7ZNZBostezYf6/TCcQqQ7j4wHzOFhtnC3qIrzpw23Zmovd9C7evA==
X-Received: by 2002:a2e:9214:: with SMTP id k20mr591843ljg.45.1611262933987;
        Thu, 21 Jan 2021 13:02:13 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.googlemail.com with ESMTPSA id s2sm498041lfc.261.2021.01.21.13.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 13:02:13 -0800 (PST)
Subject: Re: [PATCH V2] opp: Prepare for ->set_opp() helper to work without
 regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
References: <fb69353c-a35b-9b7c-46bc-d464c6dab6f5@gmail.com>
 <d60bc79ed2ac3fd2f2911449ba994b4d55bd1bfd.1611228541.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <58d15e20-8688-99be-b107-4350ff81e90a@gmail.com>
Date:   Fri, 22 Jan 2021 00:02:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <d60bc79ed2ac3fd2f2911449ba994b4d55bd1bfd.1611228541.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.01.2021 14:30, Viresh Kumar пишет:
> @@ -1952,9 +1930,16 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
>  	for (i = opp_table->regulator_count - 1; i >= 0; i--)
>  		regulator_put(opp_table->regulators[i]);
>  
> -	_free_set_opp_data(opp_table);
> +	mutex_lock(&opp_table->lock);
> +	if (opp_table->set_opp_data) {
> +		opp_table->set_opp_data->old_opp.supplies = NULL;
> +		opp_table->set_opp_data->new_opp.supplies = NULL;
> +	}
> +	mutex_unlock(&opp_table->lock);
>  
> +	kfree(opp_table->sod_supplies);
>  	kfree(opp_table->regulators);
> +	opp_table->sod_supplies = NULL;
>  	opp_table->regulators = NULL;
>  	opp_table->regulator_count = -1;

The sod_supplies should be unset under the lock.
