Return-Path: <linux-pm+bounces-11562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7928193FBEF
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 18:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30079282A55
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD48158D63;
	Mon, 29 Jul 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="G+ADUDCq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7F148FE0
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272239; cv=none; b=hM7InaqwZLw7VHdAYRwOxzfcfLsjN4qHN2sbib+vHF5xRNvPaMVyd8oBkI5aMfOINpr4CjDbQy4HecQjoEilIWoR+DdhUVDs0UJfzsH0vDETxJ01iaiPAUvGup55ZKeIKW/wtoy+BaKpHBiI5chQ/DBf6pH9vd2GYv1bQCowgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272239; c=relaxed/simple;
	bh=bbZ7H1wmERjCNQkTXDm/a4j4zT7amqqSuuM0yI34pTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLFPdS+i+YPSINfwOBAm0Cf+baf9vJ9l6ndq4jFA6IEN3+oDLoyYFWFgcA9sIOsvDJe2RM43prvpiHkPOjK2was9woPCOtoFZkz7HAuMIzKzZ3HsXhcapeyrPDdJP8K3gwie5uAYIOUBGpX+jv8fMBgHRVe8w+meBgQMSxEANYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=G+ADUDCq reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 41b7018d0856cfd8; Mon, 29 Jul 2024 18:57:14 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3705477357F;
	Mon, 29 Jul 2024 18:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722272234;
	bh=bbZ7H1wmERjCNQkTXDm/a4j4zT7amqqSuuM0yI34pTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G+ADUDCqNmz2luTF18jssNxI6aWrm6OFqV5sIj0s9Bda5N8ih3F8IkdHgvpHTU9sm
	 s/JRq/If4w4X3mcvh6j39Rz+QL9J7b+yLF0nMWEidxKr5nxem67YWObDX3G66O6oHa
	 AW6yJltBSCSvenNun5Mw6Ud6flHNf/mJWAVRqGEWfvm4ckb+ReVoSmmEaM8+DciqST
	 oDPuLlO6XSyeYQI4QNofKiuEN4u47guJE736kJCqIqJ3PChYYn9uxREuvyJSX+owg1
	 7xdm4EdCBlEpAS7KeB3LLFyIpVbD2h6xi6XQ+hecxwg2I3EGZSc1KdljlU/Vkh9aog
	 qwSMqDIbFo7rQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: daniel.lezcano@linaro.org, rafael@kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
Subject: Re: [PATCH v1 1/7] thermal/core: Encapsulate more handle_thermal_trip
Date: Mon, 29 Jul 2024 18:57:06 +0200
Message-ID: <12507467.O9o76ZdvQC@rjwysocki.net>
In-Reply-To: <20240729150259.1089814-2-daniel.lezcano@linaro.org>
References:
 <20240729150259.1089814-1-daniel.lezcano@linaro.org>
 <20240729150259.1089814-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghs
 iidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepqhhuihgtpghmrghnrghfmhesqhhuihgtihhntgdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

On Monday, July 29, 2024 5:02:50 PM CEST Daniel Lezcano wrote:
> In order to set the scene for the thresholds support which have to
> manipulate the low and high temperature boundaries for the interrupt
> support, we must pass the low and high value the incoming thresholds
> routine.
> 
> Instead of looping in the trip descriptors in
> thermal_zone_device_update(), we move the loop in the
> handle_thermal_trip() function and use it to set the low and high
> values.
> 
> As these variables can be set directly in the handle_thermal_trip(),
> we can get rid of a descriptors loop found in the thermal_set_trips()
> function as low and high are set in handle_thermal_trip().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 104 +++++++++++++++++++--------------
>  drivers/thermal/thermal_core.h |   2 +-
>  drivers/thermal/thermal_trip.c |  12 +---
>  3 files changed, 62 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 95c399f94744..5cfa2a706e96 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -425,59 +425,74 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  }
>  
>  static void handle_thermal_trip(struct thermal_zone_device *tz,
> -				struct thermal_trip_desc *td,
>  				struct list_head *way_up_list,
> -				struct list_head *way_down_list)
> +				struct list_head *way_down_list,
> +				int *low, int *high)
>  {
> -	const struct thermal_trip *trip = &td->trip;
> +	struct thermal_trip_desc *td;
>  	int old_threshold;
>  
> -	if (trip->temperature == THERMAL_TEMP_INVALID)
> -		return;
> +	for_each_trip_desc(tz, td) {
>  
> -	/*
> -	 * If the trip temperature or hysteresis has been updated recently,
> -	 * the threshold needs to be computed again using the new values.
> -	 * However, its initial value still reflects the old ones and that
> -	 * is what needs to be compared with the previous zone temperature
> -	 * to decide which action to take.
> -	 */
> -	old_threshold = td->threshold;
> -	td->threshold = trip->temperature;
> +		const struct thermal_trip *trip = &td->trip;
> +
> +		if (trip->temperature == THERMAL_TEMP_INVALID)
> +			continue;
> +
> +		if (tz->last_temperature < old_threshold ||
> +		    tz->last_temperature == THERMAL_TEMP_INIT)
> +			continue;
>  
> -	if (tz->last_temperature >= old_threshold &&
> -	    tz->last_temperature != THERMAL_TEMP_INIT) {
>  		/*
> -		 * Mitigation is under way, so it needs to stop if the zone
> -		 * temperature falls below the low temperature of the trip.
> -		 * In that case, the trip temperature becomes the new threshold.
> +		 * If the trip temperature or hysteresis has been updated recently,
> +		 * the threshold needs to be computed again using the new values.
> +		 * However, its initial value still reflects the old ones and that
> +		 * is what needs to be compared with the previous zone temperature
> +		 * to decide which action to take.
>  		 */
> -		if (tz->temperature < trip->temperature - trip->hysteresis) {
> -			list_add(&td->notify_list_node, way_down_list);
> -			td->notify_temp = trip->temperature - trip->hysteresis;
> +		old_threshold = td->threshold;
> +		td->threshold = trip->temperature;
>  
> -			if (trip->type == THERMAL_TRIP_PASSIVE) {
> -				tz->passive--;
> -				WARN_ON(tz->passive < 0);
> +		if (tz->last_temperature >= old_threshold &&
> +		    tz->last_temperature != THERMAL_TEMP_INVALID) {
> +			/*
> +			 * Mitigation is under way, so it needs to stop if the zone
> +			 * temperature falls below the low temperature of the trip.
> +			 * In that case, the trip temperature becomes the new threshold.
> +			 */
> +			if (tz->temperature < trip->temperature - trip->hysteresis) {
> +				list_add(&td->notify_list_node, way_down_list);
> +				td->notify_temp = trip->temperature - trip->hysteresis;
> +
> +				if (trip->type == THERMAL_TRIP_PASSIVE) {
> +					tz->passive--;
> +					WARN_ON(tz->passive < 0);
> +				}
> +			} else {
> +				td->threshold -= trip->hysteresis;
>  			}
> -		} else {
> +		} else if (tz->temperature >= trip->temperature) {
> +			/*
> +			 * There is no mitigation under way, so it needs to be started
> +			 * if the zone temperature exceeds the trip one.  The new
> +			 * threshold is then set to the low temperature of the trip.
> +			 */
> +			list_add_tail(&td->notify_list_node, way_up_list);
> +			td->notify_temp = trip->temperature;
>  			td->threshold -= trip->hysteresis;
> +
> +			if (trip->type == THERMAL_TRIP_PASSIVE)
> +				tz->passive++;
> +			else if (trip->type == THERMAL_TRIP_CRITICAL ||
> +				 trip->type == THERMAL_TRIP_HOT)
> +				handle_critical_trips(tz, trip);
>  		}
> -	} else if (tz->temperature >= trip->temperature) {
> -		/*
> -		 * There is no mitigation under way, so it needs to be started
> -		 * if the zone temperature exceeds the trip one.  The new
> -		 * threshold is then set to the low temperature of the trip.
> -		 */
> -		list_add_tail(&td->notify_list_node, way_up_list);
> -		td->notify_temp = trip->temperature;
> -		td->threshold -= trip->hysteresis;
> -
> -		if (trip->type == THERMAL_TRIP_PASSIVE)
> -			tz->passive++;
> -		else if (trip->type == THERMAL_TRIP_CRITICAL ||
> -			 trip->type == THERMAL_TRIP_HOT)
> -			handle_critical_trips(tz, trip);
> +
> +		if (td->threshold < tz->temperature && td->threshold > *low)
> +			*low = td->threshold;
> +
> +		if (td->threshold > tz->temperature && td->threshold < *high)
> +			*high = td->threshold;
>  	}
>  }
>  
> @@ -545,6 +560,8 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
>  {
>  	struct thermal_governor *governor = thermal_get_tz_governor(tz);
>  	struct thermal_trip_desc *td;
> +	int low = -INT_MAX, high = INT_MAX;
> +
>  	LIST_HEAD(way_down_list);
>  	LIST_HEAD(way_up_list);
>  	int temp, ret;
> @@ -580,10 +597,9 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
>  
>  	tz->notify_event = event;
>  
> -	for_each_trip_desc(tz, td)
> -		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
> +	handle_thermal_trip(tz, &way_up_list, &way_down_list, &low, &high);
>  
> -	thermal_zone_set_trips(tz);
> +	thermal_zone_set_trips(tz, low, high);
>  
>  	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
>  	list_for_each_entry(td, &way_up_list, notify_list_node)
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 4cf2b7230d04..67a09f90eb95 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -259,7 +259,7 @@ void thermal_governor_update_tz(struct thermal_zone_device *tz,
>  
>  const char *thermal_trip_type_name(enum thermal_trip_type trip_type);
>  
> -void thermal_zone_set_trips(struct thermal_zone_device *tz);
> +void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high);
>  int thermal_zone_trip_id(const struct thermal_zone_device *tz,
>  			 const struct thermal_trip *trip);
>  void thermal_zone_trip_updated(struct thermal_zone_device *tz,
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index c0b679b846b3..af0f9f5ae0de 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -76,10 +76,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
>   *
>   * It does not return a value
>   */
> -void thermal_zone_set_trips(struct thermal_zone_device *tz)
> +void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
>  {
> -	const struct thermal_trip_desc *td;
> -	int low = -INT_MAX, high = INT_MAX;
>  	int ret;
>  
>  	lockdep_assert_held(&tz->lock);
> @@ -87,14 +85,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>  	if (!tz->ops.set_trips)
>  		return;
>  
> -	for_each_trip_desc(tz, td) {
> -		if (td->threshold < tz->temperature && td->threshold > low)
> -			low = td->threshold;
> -
> -		if (td->threshold > tz->temperature && td->threshold < high)
> -			high = td->threshold;
> -	}
> -
>  	/* No need to change trip points */
>  	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
>  		return;
> 

Well, why not do the (untested) change below instead, which is way simpler?

The thermal_zone_set_trips() kerneldoc needs to be either updated or dropped
because it is not applicable any more after this and I think it's better to
just drop it.

---
 drivers/thermal/thermal_core.c |   12 ++++++++++--
 drivers/thermal/thermal_core.h |    2 +-
 drivers/thermal/thermal_trip.c |   27 +--------------------------
 3 files changed, 12 insertions(+), 29 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -551,6 +551,7 @@ void __thermal_zone_device_update(struct
 	struct thermal_trip_desc *td;
 	LIST_HEAD(way_down_list);
 	LIST_HEAD(way_up_list);
+	int low = -INT_MAX, high = INT_MAX;
 	int temp, ret;
 
 	if (tz->suspended)
@@ -584,10 +585,17 @@ void __thermal_zone_device_update(struct
 
 	tz->notify_event = event;
 
-	for_each_trip_desc(tz, td)
+	for_each_trip_desc(tz, td) {
 		handle_thermal_trip(tz, td, &way_up_list, &way_down_list);
 
-	thermal_zone_set_trips(tz);
+		if (td->threshold < tz->temperature && td->threshold > low)
+			low = td->threshold;
+
+		if (td->threshold >= tz->temperature && td->threshold < high)
+			high = td->threshold;
+	}
+
+	thermal_zone_set_trips(tz, low, high);
 
 	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node)
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -254,7 +254,7 @@ void thermal_governor_update_tz(struct t
 
 const char *thermal_trip_type_name(enum thermal_trip_type trip_type);
 
-void thermal_zone_set_trips(struct thermal_zone_device *tz);
+void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 			 const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -55,25 +55,8 @@ int thermal_zone_for_each_trip(struct th
 }
 EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
 
-/**
- * thermal_zone_set_trips - Computes the next trip points for the driver
- * @tz: a pointer to a thermal zone device structure
- *
- * The function computes the next temperature boundaries by browsing
- * the trip points. The result is the closer low and high trip points
- * to the current temperature. These values are passed to the backend
- * driver to let it set its own notification mechanism (usually an
- * interrupt).
- *
- * This function must be called with tz->lock held. Both tz and tz->ops
- * must be valid pointers.
- *
- * It does not return a value
- */
-void thermal_zone_set_trips(struct thermal_zone_device *tz)
+void thermal_zone_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	const struct thermal_trip_desc *td;
-	int low = -INT_MAX, high = INT_MAX;
 	int ret;
 
 	lockdep_assert_held(&tz->lock);
@@ -81,14 +64,6 @@ void thermal_zone_set_trips(struct therm
 	if (!tz->ops.set_trips)
 		return;
 
-	for_each_trip_desc(tz, td) {
-		if (td->threshold < tz->temperature && td->threshold > low)
-			low = td->threshold;
-
-		if (td->threshold > tz->temperature && td->threshold < high)
-			high = td->threshold;
-	}
-
 	/* No need to change trip points */
 	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
 		return;




